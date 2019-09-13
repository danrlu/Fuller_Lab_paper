Libraries made with Nextera kit (Illumina FC-121-1030 discontinued. Ask local sales rep for stand alone transposase). all 75bp paired-end sequenced on HiSeq 4000

 
1. quality control on raw sequencing data
```bash
qsub Run01FastQC.sh
```


2. trim off adaptors
```bash
qsub Run02Trim_PE.sh 
```


3. BWA paired-end map to genome
```bash
qsub Run03BWAsrt_PE.sh 
```


4. remove PCR duplicates. For read pairs that both read1 and read2 map to the same genomic location, only keep one of them.
```bash
qsub Run04RmDup_PE.sh 
```


5. only keep reads that have MAPQ bigger or equal to 20 (for BWA, that is 1 in 100 error rate, and multimapper whose MAPQ is 0 will be removed), and map to the main chromosomes (to keep the analysis simple)

convert bam to bed format, and call adjust_bed.py to keep only the first 9bp of each read (for both ends of the read pairs), which corresponds to the stretch of DNA that the Tn5 transposase binds and therefore is accessible. 
```bash
qsub Run05Filter_B2B_AdjBed_Q20.sh
```


6. mapping statistics. these operates on the .bam files to see mapping metrics. the size metrics should show periodicity of fragment size that correspond to fragments that enclose no nucleosome, 1 nucleosome, 2 nucleosomes etc. This correlates with quality of ATAC-seq library.
```bash
qsub Run05IdxStats_PE.sh
qsub Run06Flagstat_Q20_PE.sh
qsub Run06SizeMetrics_PE.sh
```


## below are combining all replicates:

7. for viewing in genomic browser

7.1 combine the adjusted .bed file for replicates of the same condition into 1 bed file
```bash
qsub Run_merge_adj.bed.sh
```


7.2 convert .bed to .bedgraph which is needed to convert to .bigwig for genomic viewer viewing. during conversion to .bedgraph, each library is normalized by total read counts. Note the reads at this step is filtered by deplicate, MAPQ and on main chromasomes. 
```bash
qsub RunBedtoBGraphtoBW_Q20.sh
```


8. for peak calling

8.1 combine the .bam files for replicates of the same condition into 1 .bam file
```bash
qsub Run_merge_bam.sh
```


8.2 for paired-end reads, MACS2 only use read1 for peak calling, so calling peaks with the .bam file will miss half of the data. So first convert the combined .bam to .bed first, and for .bed files, MACS2 will include all reads for peak calling (because MACS2 do not identify read pairs in .bed files)

for ATAC-seq, if using the original mapped .bam file, --nomodel --shift -50 --extsize 100 will use the 5' end of reads to build pileup and call peaks. Alternatively, if using the adjusted.bed which only contains the 5' end, should do --nomodel --shift 0 --extsize 9.
```bash
qsub Run_MACS_no_ctrl.sh
```


#### for nucleosome calling. This step needs more reads than identifying open chromatin, so is done after combining all replicates.




