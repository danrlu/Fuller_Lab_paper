## CAGE

Library was made with protocol: https://www.ncbi.nlm.nih.gov/pubmed/24927836
76bp paired-end on Illumina NextSeq 500

#### 1. index the genome. CAGEr uses BSgenome.Dmelanogaster.UCSC.dm6, so did the mapping to UCSC genome build. 
`sbatch Run00Index.sh`


sbatch Run02Trim_SE.sh
# trim off low quality bases

sbatch Run04Map_pass2.sh
# map to genome with STAR (76bp is long enough to may include splicing junctions)

sbatch Run04Index_Stats_corrected.sh
# filter the .bam file to only include uniquely mapped reads and reads on the main chromosomes
# index the filtered .bam file


######### CAGEr build clusters ##########
The version of CAGEr used is 1.20.0 with R/3.4.4. It has a bug that when reading from .bam files, reads with splicing/indels on - strand all had misidentified 5' position (TSS), likely due to reading bam step according to CAGEr update log. The solution is to use bedtools to count number of TSS (5' of reads) at each genomic location, convert to ctss.txt format (see CAGEr manual) as CAGEr input.
1.22.0 wouldn't run through, 1.24.0 generated a lot more TSS clusters on - strand than on + strand. So there were no better options than 1.20.0.


sbatch Run08Bed_gCov_fw.sh
sbatch Run08Bed_gCov_rv.sh
# use bedtools to count number of TSS (5' of reads) at each genomic location
# note the output from these scripts have no strand information, so had to count each strand separately

sbatch Run13convert_ctss.sh
# convert the output from Run08 to ctss.txt format (see CAGEr manual) as CAGEr input

sbatch Run05CAGEr.sh
# run CAGEr to build TSS clusters


######### to count reads in TSS clusters
sbatch Run06_B2B_adjBed.sh
# convert .bam to .bed file keeping only the most 5' 1bp of the read (TSS). This is preparation for the next step.

sbatch Run14Bedtools_coverage_array.sh
# use the consensus TSS clusters built by CAGEr, and the adjusted .bed file from Run06 to count TSS expression level for each consensus TSS cluster.
