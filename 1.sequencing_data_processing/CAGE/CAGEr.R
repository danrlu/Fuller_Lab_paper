library(tidyverse)
library(magrittr)
library("MultiAssayExperiment")
library("SummarizedExperiment")
library(BSgenome.Dmelanogaster.UCSC.dm6)
library(CAGEr)

sessionInfo()


options(scipen=999) # to prevent 16e+10 in output files


ctss_cutoff = 18
singleton_cutoff = 90
cluster_cutoff = 90



filename_list=c("B1_ctss.txt","B2_ctss.txt","H1_ctss.txt","H2_ctss.txt")

myCAGEset <- new( "CAGEset", genomeName     = "BSgenome.Dmelanogaster.UCSC.dm6"
               , inputFiles     = filename_list
               , inputFilesType = "ctss"
               , sampleLabels   = sub( "_ctss.txt", "", basename(filename_list))
)

getCTSS(myCAGEset)



sampleLabels(myCAGEset)
librarySizes(myCAGEset)


########### merge replicates 

mergeSamples(myCAGEset, mergeIndex = c(1,1,2,2), 
            mergedSampleLabels = c("bam", "HS72"))



############### normalize counts to power law distribution
normalizeTagCount(myCAGEset, method = "none") # result is tag per 10million. did 10^5 in first try by accident. 

save(myCAGEset, file="CAGEset2.object")
# load("CAGEset2.object")


# exportCTSStoBedGraph(myCAGEset, values = "raw", format = "BigWig")


############


############

################
################# plot to decide threshold between noise and signal for the clustering of TSS
ctss=CTSStagCount(myCAGEset)

for (nm in sampleLabels(myCAGEset)) {
	ctss$log10X=log10(ctss[[nm]])
	(ctss %>% dplyr::filter(nm > 0) %>% ggplot(aes(log10X)) + geom_histogram(bins=200) + xlab(paste0("log10(",nm,")")) ) %>% ggsave(filename=paste0(nm,"_raw_counts_histogram.pdf"))
	(ctss %>% dplyr::filter(nm > 0) %>% ggplot(aes(log10X)) + geom_histogram(bins=200) + scale_y_log10() + xlab(paste0("log10(",nm,")")) ) %>% ggsave(filename=paste0(nm,"_raw_counts_logy_histogram.pdf"))
}






#### cluster nearby CAGE TSS into TSS clusters. done for EACH sample
####### make sure to change tpm thresholds if changing T in normalization step
####### use paraclu and breaking into smaller clusters as cluster method


clusterCTSS(object = myCAGEset, threshold = ctss_cutoff, thresholdIsTpm = F, nrPassThreshold = 1, method = "distclu", maxDist = 40,removeSingletons = TRUE, keepSingletonsAbove = singleton_cutoff, maxLength = 200, reduceToNonoverlapping = T, useMulticore = TRUE, nrCores = 8) # note that aiming to filter singleton with same tpm cutoff as the other TSS clusters, but the latter is done after CAGEr, so here only do a very minimum singleton filtering.

save(myCAGEset, file="CAGEset_distclu.object")

# load(file="CAGEset_distclu.object")
# sampleLabels(myCAGEset)

##### calculate TSS tag count distribution for each sample
cumulativeCTSSdistribution(myCAGEset, clusters = "tagClusters") # computing step 1
quantilePositions(myCAGEset, clusters = "tagClusters", qLow = 0.1, qUp = 0.9) # computing step 2

for (nm in sampleLabels(myCAGEset)) {
tc <- tagClusters(myCAGEset, sample = nm, returnInterquantileWidth = TRUE, qLow = 0.1, qUp = 0.9)
write.table(tc, paste0("clusterTSS_",nm,".txt"), sep="\t", quote=F, row.names = F, col.names = T)
}

exportToBed(object = myCAGEset, what = "tagClusters", qLow = 0.1, qUp = 0.9, oneFile = TRUE)

plotInterquantileWidth(myCAGEset, clusters = "tagClusters", tpmThreshold = cluster_cutoff, qLow = 0.1, qUp = 0.9) # note the tpm threshold here is for each cluster, which is sum of tpm of TSS within the cluster


##### create consensus promoters combining all samples
aggregateTagClusters(myCAGEset, tpmThreshold = cluster_cutoff, excludeSignalBelowThreshold = FALSE, maxDist = 1) # excludeSignal..=F will construct consensus clusters using clusters only above tpmthreshold, but will include those below threshold in calculating tpm. 
# If using TRUE, those below threshold will have tpm = 0

con_ctss_tpm=consensusClustersTpm(myCAGEset)
write.table(con_ctss_tpm, "consensusClustertpm.txt", sep="\t", quote=F, col.names=T, row.names=T)


con_ctss=consensusClusters(myCAGEset)
write.table(con_ctss, "consensusCluster.txt", sep="\t", quote=F, col.names=T, row.names=F)


##### expression profiles
getExpressionProfiles(myCAGEset, what = "consensusClusters", tpmThreshold = cluster_cutoff, nrPassThreshold = 1, method = "som", xDim = 4, yDim = 2)
plotExpressionProfiles(myCAGEset, what = "consensusClusters")


#### shifting promoters
cumulativeCTSSdistribution(myCAGEset, clusters = "consensusClusters") # computing step 1

scoreShift(myCAGEset, groupX = "bam", groupY = "HS72", testKS = TRUE, useTpmKS = TRUE) # computing step 2

shifting.promoters <- getShiftingPromoters(myCAGEset, tpmThreshold = cluster_cutoff ) # Consensus clusters with total CAGE signal >= tpmThreshold in each of the compared groups will be returned.
write.table(shifting.promoters, "shifting_promoters_xbam_yHS72.txt", sep="\t", quote=F, row.names = F, col.names = T)

