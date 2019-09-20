#!/bin/bash -l
#SBATCH -J B2B
#SBATCH -p standard
#SBATCH --mem=20G
#SBATCH -t 12:0:0
#SBATCH -p batch
#SBATCH --account=mtfuller
#SBATCH --array=0-7


module add bedtools
module add python/2.7

module list

cd $SLURM_SUBMIT_DIR

#####################
# in line 9 (#$ -t 1-1), if have more than 1 libraries, for example, 3 libraries (each have R1 and R2 for paired end) change 1-1 to 1-3

name_list=(*_trimmed_Aligned.sortedByCoord.out.Q255.chr.bam) # make a list of all R1.fastq files in the folder

Input1=${name_list[$SLURM_ARRAY_TASK_ID]}  # don't change this line. take the nth ($SGE_TASK_ID-th) file in name_list
#####################


Output2=`echo $Input1 | sed 's/.bam/.bed/'`
echo $Output2

bedtools bamtobed -i $Input1 > $Output2

python adjust_bed.py $Output2

Output3=`echo $Output2 | sed 's/.bed/.adj.bed/'`
Output4=`echo $Output3 | sed 's/.adj.bed/.adj.srt.bed/'`
sort -k1,1 -k2,2n $Output3 > $Output4

