## RNA-seq

library were made with SMARTer Stranded RNA-Seq Kit (Clonetech 634839). Illumina NextSeq 500, 75bp paired-end.


#### 1. run QC on raw sequencing data
```bash
qsub Run01FastQC.sh
```


#### 2. trim adaptor and low quality bases
```bash
qsub Run02Trim_PE.sh
```


#### 3. map to the genome. 
STAR does 2-pass mapping, the 1st pass is mostly detect novel splice juncitons, and 2nd pass do the mapping using all known and novel splice junctions to improve accuracy
```bash
qsub Run03Map_pass1.sh
```
Once Run03 is done, map again. This will generate both .bam file and read count table for genes (...ReadsPerGene.out.tab)
```bash
qsub Run04Map_pass2.sh
```


#### 4a. get mapping statistics, keeping only reads uniquely mapped to the main chromosomes, and index the filtered .bam file
```bash
qsub Run05Index_filter.sh
```


#### 4b. (can run in parallel to 4a) prepare the count table for differential expression analysis
REPLACE Y with a number: 2 for unstranded RNAseq, 3 for forward strand, 4 for reverse strand RNAseq (SMARTer stranded RNA-seq kit use 3)
If unclear, open one of the *_ReadsPerGene.out.tab.srt.txt file Run04Map_pass2.sh generate, first column is gene ID, 2nd column is unstranded, 3rd is forward strand, 4 is reverse strand. If col 3 is similar to col 2, use Y=3, if col 4 is similar to col 2, use Y=4, if col 3 is similar to col 4 and their sum is similar to 2, use Y=2.
```bash
qsub Run05CountTable.sh Y
```


#### 5. convert .bam to .bw for viewing. 
Normalized using RPKM (per bin) = number of reads per bin / (number of mapped reads (in millions) * bin length (kb)). bin length here is 10bp
```bash
Run06BamtoBW.sh
```


The whole list of scripts can be submitted as dependency jobs in one go (remember to replace Y with a number):
qsub Run01FastQC.sh
qsub -hold_jid FastQC Run02Trim_PE.sh
qsub -hold_jid Trim_PE Run03Map_pass1.sh
qsub -hold_jid Map_pass1 Run04Map_pass2.sh
qsub -hold_jid Map_pass2 Run05Index_filter.sh 
qsub -hold_jid Map_pass2 Run05CountTable.sh Y
qsub -hold_jid Index_filter Run06BamtoBW.sh




1/14/2018 on SGE with

modsappsdir

gcc/5.2.0

fastqc/0.11.2

trim_galore/0.4.1

perl-scg/5.24.0

cutadapt/1.8.1(default)

igv/2.3.82

samtools/1.5

igvtools/2.3.82

STAR_2.5.1b

Python 2.7.6

deepTools 2.5.4-2-5ee467f
