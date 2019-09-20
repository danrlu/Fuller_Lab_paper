#!/bin/bash -l
#SBATCH -J Bed2Bw
#SBATCH -p standard
#SBATCH --mem=40G
#SBATCH -t 12:0:0
#SBATCH -p batch
#SBATCH --account=mtfuller


cd $SLURM_SUBMIT_DIR
# this needs 6G of memory. 3G didn't let some of the library run.
module add bedtools

module list

bedtools genomecov -i ../B1_trimmed_Aligned.sortedByCoord.out.Q255.chr.bed \
-g ../dm6.ucsc.chrom.sizes \
-d -5 -strand - > B1_trimmed_Aligned.sortedByCoord.out.Q255.chr.bed_rv_count.txt

bedtools genomecov -i ../B2_trimmed_Aligned.sortedByCoord.out.Q255.chr.bed \
-g ../dm6.ucsc.chrom.sizes \
-d -5 -strand - > B2_trimmed_Aligned.sortedByCoord.out.Q255.chr.bed_rv_count.txt

bedtools genomecov -i ../H1_trimmed_Aligned.sortedByCoord.out.Q255.chr.bed \
-g ../dm6.ucsc.chrom.sizes \
-d -5 -strand - > H1_trimmed_Aligned.sortedByCoord.out.Q255.chr.bed_rv_count.txt

bedtools genomecov -i ../H2_trimmed_Aligned.sortedByCoord.out.Q255.chr.bed \
-g ../dm6.ucsc.chrom.sizes \
-d -5 -strand - > H2_trimmed_Aligned.sortedByCoord.out.Q255.chr.bed_rv_count.txt


