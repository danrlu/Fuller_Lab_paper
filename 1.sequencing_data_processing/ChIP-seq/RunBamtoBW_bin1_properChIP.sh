#!/bin/bash
#SBATCH -J bam_to_bw
#SBATCH --mem-per-cpu=6G
#SBATCH -t 12:0:0
#SBATCH -p batch
#SBATCH --account=mtfuller
#SBATCH --cpus-per-task=8



module add deepTools
module list


for Input in S*_sorted.bam
do
	Output=`echo $Input | sed 's/.bam/.bin1.bw/'`
	bamCoverage -b $Input -o $Output --extendReads 300 --normalizeUsing CPM --binSize 1 -p 8
done

