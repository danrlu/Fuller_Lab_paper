#!/bin/bash
#SBATCH -J index   # name of the job
#SBATCH --mem=10G     # reserve 30G (per processor) of memory for the job
#SBATCH -t 12:0:0    # the job will be killed after 24hr if still not completed
#SBATCH -p batch    # the queue to send it to. Keep this as it is.
#SBATCH --account=mtfuller   # SUNID of your PI
#SBATCH --cpus-per-task=1
#SBATCH --array=0-7


cd $SLURM_SUBMIT_DIR     # all the output of the file will be in the same directory as the .sh script


module add samtools
module list

cd trim_SE
################
name_list=(*.sortedByCoord.out.bam)
################


Input=${name_list[$SLURM_ARRAY_TASK_ID]}

Output_idxstat=`echo $Input | sed 's/.bam/.idxstat/'`

Output0=`echo $Input | sed 's/.bam/.Q255.chr.bam/'`

#samtools flagstat $Input   # statistics on the bam file

#samtools index $Input   # index the bam file for fast access

#samtools idxstats $Input > $Output_idxstat   # statistics on the bam file

samtools view -b -q 255 $Input chr2L chr2R chr3L chr3R chr4 chrX chrY > $Output0
samtools index $Output0
