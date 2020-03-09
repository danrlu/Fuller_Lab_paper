#!/bin/bash -l
#SBATCH -J Bed2Bw
#SBATCH -p standard
#SBATCH --mem=20G
#SBATCH -t 12:0:0
#SBATCH -p batch
#SBATCH --account=mtfuller


cd $SLURM_SUBMIT_DIR
# this needs 6G of memory. 3G didn't let some of the library run.
module add bedtools/2.25.0
module add ucsc_tools


bedtools genomecov -i B1_trimmed_Aligned.sortedByCoord.out.Q255.chr.bed \
-g dm6.ucsc.chrom.sizes \
-scale 0.39917876155 -bg -5 > B1_trimmed_Aligned.sortedByCoord.out.Q255.chr.bed.bg

bedtools genomecov -i B2_trimmed_Aligned.sortedByCoord.out.Q255.chr.bed \
-g dm6.ucsc.chrom.sizes \
-scale 0.423314826009 -bg -5 > B2_trimmed_Aligned.sortedByCoord.out.Q255.chr.bed.bg

bedtools genomecov -i H1_trimmed_Aligned.sortedByCoord.out.Q255.chr.bed \
-g dm6.ucsc.chrom.sizes \
-scale 0.466172343729 -bg -5 > H1_trimmed_Aligned.sortedByCoord.out.Q255.chr.bed.bg

bedtools genomecov -i H2_trimmed_Aligned.sortedByCoord.out.Q255.chr.bed \
-g dm6.ucsc.chrom.sizes \
-scale 0.361411566601 -bg -5 > H2_trimmed_Aligned.sortedByCoord.out.Q255.chr.bed.bg

bedtools genomecov -i K1_trimmed_Aligned.sortedByCoord.out.Q255.chr.bed \
-g dm6.ucsc.chrom.sizes \
-scale 0.430721133134 -bg -5 > K1_trimmed_Aligned.sortedByCoord.out.Q255.chr.bed.bg

bedtools genomecov -i K2_trimmed_Aligned.sortedByCoord.out.Q255.chr.bed \
-g dm6.ucsc.chrom.sizes \
-scale 0.456557461774 -bg -5 > K2_trimmed_Aligned.sortedByCoord.out.Q255.chr.bed.bg

bedtools genomecov -i S1_trimmed_Aligned.sortedByCoord.out.Q255.chr.bed \
-g dm6.ucsc.chrom.sizes \
-scale 0.422408571988 -bg -5 > S1_trimmed_Aligned.sortedByCoord.out.Q255.chr.bed.bg

bedtools genomecov -i S2_trimmed_Aligned.sortedByCoord.out.Q255.chr.bed \
-g dm6.ucsc.chrom.sizes \
-scale 0.428449914055 -bg -5 > S2_trimmed_Aligned.sortedByCoord.out.Q255.chr.bed.bg




for Input in *.Q255.chr.bed.bg
do
	Output=`echo $Input | sed 's/.bed.bg/.bw/'`
	bedGraphToBigWig $Input dm6.ucsc.chrom.sizes $Output
done

