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
-scale 0.39917876155 -bg -5 -strand + > B1_trimmed_Aligned.sortedByCoord.out.Q255.chr.bed_fw.bg

bedtools genomecov -i B2_trimmed_Aligned.sortedByCoord.out.Q255.chr.bed \
-g dm6.ucsc.chrom.sizes \
-scale 0.423314826009 -bg -5 -strand + > B2_trimmed_Aligned.sortedByCoord.out.Q255.chr.bed_fw.bg

bedtools genomecov -i H1_trimmed_Aligned.sortedByCoord.out.Q255.chr.bed \
-g dm6.ucsc.chrom.sizes \
-scale 0.466172343729 -bg -5 -strand + > H1_trimmed_Aligned.sortedByCoord.out.Q255.chr.bed_fw.bg

bedtools genomecov -i H2_trimmed_Aligned.sortedByCoord.out.Q255.chr.bed \
-g dm6.ucsc.chrom.sizes \
-scale 0.361411566601 -bg -5 -strand + > H2_trimmed_Aligned.sortedByCoord.out.Q255.chr.bed_fw.bg




for Input in *.Q255.chr.bed_fw.bg
do
	Output=`echo $Input | sed 's/.bed_fw.bg/.fw.bw/'`
	bedGraphToBigWig $Input dm6.ucsc.chrom.sizes $Output
done



