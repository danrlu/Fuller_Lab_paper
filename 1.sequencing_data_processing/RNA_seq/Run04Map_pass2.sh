#!/bin/bash

#$ -N Map_pass2
#$ -q standard
#$ -cwd
#$ -e ./logs
#$ -o ./logs
#$ -R y
#$ -l h_vmem=10G
#$ -w e
#$ -pe shm 4
#$ -t 1-9


module add STAR/2.5.1b

cd trim_PE  # change directory to where trimmed reads are


####################
# in line 12 (#$ -t 1-1), if have more than 1 libraries, for example, 3 libraries (each have R1 and R2 for paired end) change 1-1 to 1-3

star_index=/srv/gsfs0/projects/fuller/share/Genome/emsembl_genome_gtf/STAR_indexed  # indexed genome location

name_list=(*_R1_001_val_1.fq) # make a list of all R1.fastq files in the folder
#####################



Input1_trimmed=${name_list[$(expr $SGE_TASK_ID - 1)]} # don't change this. take the nth ($SGE_TASK_ID-th) file in name_list

Input2_trimmed=`echo $Input1_trimmed | sed 's/_R1_001_val_1/_R2_001_val_2/'`   # replace R1 in name of read 1 to generate file name of read 2



junction=`echo star_pass1/*SJ.out.tab`  # a list of splice junctions detected by STAR from pass 1
pass2_prefix=${Input1_trimmed%.*}_ # prefix for pass 2 outputs


STAR --runThreadN 4 \
--runMode alignReads \
--quantMode GeneCounts \
--genomeDir $star_index \
--alignIntronMax 100000 \
--alignMatesGapMax 100000 \
--outFilterMismatchNoverLmax 0.04 \
--sjdbFileChrStartEnd $junction \
--readFilesIn $Input1_trimmed $Input2_trimmed \
--outSAMtype BAM SortedByCoordinate \
--limitBAMsortRAM 10000000000 \
--outFileNamePrefix $pass2_prefix



# --quantMode GeneCounts \   # count reads per gene after mapping. Only reads overlap with only one gene will be counted.
# --outSAMtype BAM Unsorted SortedByCoordinate \  # output type is bam, generate 2 output files, one is sorted by read name ("Unsorted"), where mates are next to each other, the other sorted by genome coordinate. STAR sorting is much more efficient than samtools. 
# --limitBAMsortRAM 10000000000 \  # RAM for sort bam in bytes, the default is usually not enough

