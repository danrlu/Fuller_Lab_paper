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
module add ucsc_tools

module list


bedtools genomecov -i B1_trimmed_Aligned.sortedByCoord.out.Q255.chr.bed \
-g dm6.ucsc.chrom.sizes \
-scale 0.39917876155 -bg -5 -strand - > B1_trimmed_Aligned.sortedByCoord.out.Q255.chr.bed_rv.bg

bedtools genomecov -i B2_trimmed_Aligned.sortedByCoord.out.Q255.chr.bed \
-g dm6.ucsc.chrom.sizes \
-scale 0.423314826009 -bg -5 -strand - > B2_trimmed_Aligned.sortedByCoord.out.Q255.chr.bed_rv.bg

bedtools genomecov -i H1_trimmed_Aligned.sortedByCoord.out.Q255.chr.bed \
-g dm6.ucsc.chrom.sizes \
-scale 0.466172343729 -bg -5 -strand - > H1_trimmed_Aligned.sortedByCoord.out.Q255.chr.bed_rv.bg

bedtools genomecov -i H2_trimmed_Aligned.sortedByCoord.out.Q255.chr.bed \
-g dm6.ucsc.chrom.sizes \
-scale 0.361411566601 -bg -5 -strand - > H2_trimmed_Aligned.sortedByCoord.out.Q255.chr.bed_rv.bg





for Input in *.Q255.chr.bed_rv.bg
do
	Output=`echo $Input | sed 's/.bed_rv.bg/.rv.bw/'`
	bedGraphToBigWig $Input dm6.ucsc.chrom.sizes $Output
done

