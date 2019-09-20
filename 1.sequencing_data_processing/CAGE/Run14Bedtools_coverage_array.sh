#!/bin/bash -l
#SBATCH -J cov
#SBATCH -p standard
#SBATCH --mem=20G
#SBATCH -t 12:0:0
#SBATCH -p batch
#SBATCH --account=mtfuller
#SBATCH --cpus-per-task=1
#SBATCH --array=0-7

cd $SLURM_SUBMIT_DIR

module add bedtools/2.25.0
module list


name_list=(../*_trimmed_Aligned.sortedByCoord.out.Q255.chr.adj.srt.bed) # make a list of all R1.fastq files in the folder

input=${name_list[$SLURM_ARRAY_TASK_ID]}  # don't change this line. take the nth ($SGE_TASK_ID-th) file in name_list

output=`echo ${input##*/} | sed 's/^/counts_/; s/_trimmed_Aligned.sortedByCoord.out.Q255.chr.adj.srt.bed/.txt/'`
echo $output
bedtools coverage -counts -s -sorted -a consensusCluster_UCSC.bed -b $input | awk -v OFS='\t' '{print $4, $7}' > $output



