#!/bin/bash

#$ -N FastQC   # name of the job
#$ -q standard   # submit to standard queue
#$ -cwd   # all the output of the file will be in the same directory as the .sh script
#$ -l h_vmem=12G   # reserve 12G of memory for the job
#$ -w e   # verify the script and abort if there is an error


module add fastqc/0.11.2  # so the system knows where to find fastqc
module list

mkdir -p logs
mkdir -p fastQC


########################
# if fastq files are compressed, uncomment one of the following lines
# unzip *.zip 
gunzip *.gz 
########################

fastqc *.fastq --outdir fastQC  # run quality control in all samples, output to fastQC folder
