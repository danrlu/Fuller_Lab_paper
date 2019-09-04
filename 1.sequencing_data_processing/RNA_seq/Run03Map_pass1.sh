#!/bin/bash

#$ -N Map_pass1
#$ -q standard
#$ -cwd
#$ -e ./logs
#$ -o ./logs
#$ -R y    # reserve resources as they become available
#$ -l h_vmem=10G
#$ -w e
#$ -pe shm 4     # use 4 processors for each job
#$ -t 1-9


module add STAR/2.5.1b


cd trim_PE  # change directory to where trimmed reads are


###################
# in line 12 (#$ -t 1-1), if have more than 1 libraries, for example, 3 libraries (each have R1 and R2 for paired end) change 1-1 to 1-3

star_index=/srv/gsfs0/projects/fuller/share/Genome/emsembl_genome_gtf/STAR_indexed  # indexed genome location

name_list=(*_R1_001_val_1.fq) # make a list of all R1.fastq files in the folder

####################


Input1_trimmed=${name_list[$(expr $SGE_TASK_ID - 1)]} # don't change this line. take the nth ($SGE_TASK_ID-th) file in name_list

Input2_trimmed=`echo $Input1_trimmed | sed 's/_R1_001_val_1/_R2_001_val_2/'`   # replace R1 in name of read 1 to generate file name of read 2



mkdir -p star_pass1  # create directory for STAR pass 1 output
pass1_prefix=star_pass1/${Input1_trimmed%.*}_  # prefix for pass 1 outputs


STAR --runThreadN 4 \
--runMode alignReads \
--genomeDir $star_index \
--alignSJoverhangMin 10 \
--alignIntronMax 100000 \
--alignMatesGapMax 100000 \
--outFilterMismatchNoverLmax 0.04 \
--readFilesIn $Input1_trimmed $Input2_trimmed \
--outFileNamePrefix $pass1_prefix \
--outSAMtype None


# STAR --runThreadN 4 \  # use 4 threads in parallell 
# --runMode alignReads \  # align reads
# --genomeDir $star_index \  # where the index is
# --alignSJoverhangMin 10 \  # for reads spanning splice junctions, need to have > 10bp align to both exons to be included in output
# --alignIntronMax 100000 \  # maximum intron length. Minimum is 21bp by default.
# --alignMatesGapMax 100000 \  # maximum distance between reads in a pair
# --outFilterMismatchNoverLmax 0.04 \  # max mismatch allowed = read lenght x 0.04
# --readFilesIn $Input1_trimmed $Input2_trimmed \  # read 1 and read 2 input files
# --outFileNamePrefix $pass1_prefix \  # output prefix
# --outSAMtype None  # don't output the bam file, since the goal of pass 1 is to generate the splice junction file
