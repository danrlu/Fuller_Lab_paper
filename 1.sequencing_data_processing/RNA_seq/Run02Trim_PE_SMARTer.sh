#!/bin/bash

#$ -N Trim_PE
#$ -q standard
#$ -cwd
#$ -e ./logs    # put error log files in 'logs' folder
#$ -o ./logs    # put output log files in 'logs' folder
#$ -l h_vmem=12G
#$ -w e 
#$ -t 1-9

module load perl-scg/5.24.0
module load trim_galore/0.4.1
module add cutadapt/1.8.1
module list

mkdir -p trim_PE # make directory for output


#####################
# in line 10 (#$ -t 1-1), if have more than 1 libraries, for example, 3 libraries (each have R1 and R2 for paired end) change 1-1 to 1-3

# In last line, remove "--clip_R1 3" if not using SMARTer stranded RNAseq kit.

name_list=(*_R1*.fastq) # make a list of all fastq files in the folder which has "R1" (read 1) in file name
# name_list=(a.fastq b.fastq) # or write a full list of fastq files

Input1=${name_list[$(expr $SGE_TASK_ID - 1)]} # don't change this line
# take the nth ($SGE_TASK_ID-th) file in name_list

Input2=`echo $Input1 | sed 's/_R1/_R2/'`
# replace R1 in name of read 1 to generate file name of read 2
#####################


trim_galore --quality 20 --stringency 1 --length 30 --paired_end --clip_R1 3 $Input1 $Input2 --output_dir trim_PE/
# At 3' end, trim off bases that has quality < 20 (default), 20 means that there is 1% of change the base is incorrectly identified
# Then at 3' end, trim off bases that has >=1bp overlap with the adapter sequence. The adapter sequence is automatically identified by the program
# Discard reads shorter than 30bp after trimming. The cutoff is arbituary, but short than this won't map efficiently

# 'paired_end' mode keeps mate-to-mate correspondence, meaning that if read 1 is deleted, read 2 will be deleted too. that's why the input needs to include both R1.fastq and R2.fastq 
# SMARTer stranded RNAseq kit specific: trim the first 3bp from read 1 
# output all files in trim_PE folder
