## CAGE

Library was made with protocol: https://www.ncbi.nlm.nih.gov/pubmed/24927836

Note there is **no PCR amplification step**

76bp paired-end on Illumina NextSeq 500


#### 1. index the genome. 
CAGEr uses BSgenome.Dmelanogaster.UCSC.dm6, so did the mapping to UCSC genome, which required a different index. 

`sbatch Run00Index.sh`

#### 2. trim off low quality bases
`sbatch Run02Trim_SE.sh`

#### 3.map to genome with STAR (76bp is long enough to may include splicing junctions)
`sbatch Run04Map_pass2.sh`


#### 4. filter and index
Filter the .bam file to only include uniquely mapped reads and reads on the main chromosomes, then index the filtered .bam file

`sbatch Run04Index_Stats_corrected.sh`

<br>

#### 5. CAGEr build clusters 
**The version of CAGEr used is 1.20.0 with R/3.4.4**. It has a bug that when reading from .bam files, reads with splicing/indels on - strand all had misidentified 5' position (TSS), likely from the reading bam step according to CAGEr update log. The solution is to use bedtools to count numbers of TSS (5' of reads) at each genomic location, convert to ctss.txt format (see CAGEr manual) as CAGEr input.

CAGEr 1.22.0 wouldn't run through, 1.24.0 generated a lot more TSS clusters on - strand than on + strand. So 1.20.0 was the best option.

#### 5.1 use bedtools to count number of TSS (5' of reads) at each genomic location
note the output from these scripts have no strand information, so had to count each strand separately
```{bash}
sbatch Run08Bed_gCov_fw.sh
sbatch Run08Bed_gCov_rv.sh
```

#### 5.2 convert the output from Run08 to ctss.txt format (see CAGEr manual) as CAGEr input
`sbatch Run13convert_ctss.sh`

#### 5.3 run CAGEr to build TSS clusters
`sbatch Run05CAGEr.sh`

This script calls CAGEr.R to:

  1) **identify all reasonably expressed TSS**. The cutoff for what is "reasonably expressed" is arbitrary. A lower cutoff will include more TSS and give bigger and more TSS clusters, and a higher cutoff will give smaller/less TSS clusters. So the cutoff probalby depends on downstream applications. For us, we want known spermatocyte-specific genes contain only spermatocyte-specific CAGE clusters, in other words, their TSS expression level in spermatogonia would be considered not expressed. 

  2) **for each sample, group nearby TSS into TSS clusters**. The cutoff for what is "nearby" is arbitrary. A larger distance will include further apart TSS into 1 big cluster, and a smaller distance will break this big cluster into smaller ones. Because we only consider genes with "alternative promoters" if they have a new cluster in spermatocyte sample, so we want smaller clusters. 

  3) **combine TSS clusters from different samples into 1 set of consensus clusters**. This is for comparing CAGE expression level across different samples. See notes on 2.Differential_expression_analysis.

  4) **score shifts within TSS clusters**. Within a consensus cluster, a shift score can be calculated to quantify the different usage of TSS between samples. The result was not used for the paper. The options were either building larger TSS clusters and consider the shifts within them, or building smaller TSS clusters and not consider the shifts but instead focus on the appearance of new cluster, and we sticked with the latter one.


<br>

#### 6. count reads in TSS clusters
#### 6.1 convert .bam to .bed file keeping only the most 5' 1bp of the read (TSS). 
This script first convert .bam to .bed (then used in step 7 below), they only keep the most 5' 1bp in .adj.srt.bed which is preparation for the next step.

`sbatch Run06_B2B_adjBed.sh`

#### 6.2 use the consensus TSS clusters built by CAGEr, and the adjusted .adj.srt.bed file from 6.1 to count TSS expression level for each consensus TSS cluster.
`sbatch Run14Bedtools_coverage_array.sh`

<br>

#### 7. create strand specific .bigwig for genomic viewer
#### 7.1 calculate normalization factor
For each library, count total number of reads in .bed files generated in step 6.1 using `wc -l`, then calculate 10000000/total reads as the scale factor for the next step. This number is effectively 10x RPM to avoid data range less than 1.

#### 7.2 create normalized .bw files
The input is the .bed file containing ENTIRE reads generated in step 6.1. Here use bedtools to only keep 1bp at the 5' of reads, then convert to .bedgraph with `bedtools genomecov` and `-scale` option is the number from 7.1, then covert to .bw. 

Split forward and reverse strand to be used for genomic viewer:
`Run08Bed2BW_gCov_fw.sh`

`Run08Bed2BW_gCov_rv.sh`

Combines both strands to be used for plotting CAGE heatmaps in the paper. 
`Run08Bed2BW_gCov_all.sh`

<br>

===================
last used on SLURM 8/10/2018-3/5/2019

Trim Galore version: 0.4.4_dev

Cutadapt version: 1.16

STAR/2.5.4b

samtools/1.9

bedtools/2.27.1

gcc/5.2.0

python/2.7

ucsc_tools/377

R/3.4.4 (CAGEr and related package versions see "Session_info.txt")
