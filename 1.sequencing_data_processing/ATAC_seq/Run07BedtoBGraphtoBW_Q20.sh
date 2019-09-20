#$ -N Bed_to_BW
#$ -q standard
#$ -cwd
#$ -e ./logs
#$ -o ./logs
#$ -R y
#$ -l h_vmem=9G
#$ -w e

# this needs 6G of memory. 3G didn't let some of the library run.
module add bedtools/2.25.0
module add ucsc_tools

bedtools genomecov -i aly.adj.bed \
-g Drosophila_melanogaster.BDGP6.dna.toplevel.fa.fai \
-scale 0.427948036666 -bg > aly.adj.bed.bg

bedtools genomecov -i bam.adj.bed \
-g Drosophila_melanogaster.BDGP6.dna.toplevel.fa.fai \
-scale 0.404090250001 -bg > bam.adj.bed.bg


bedtools genomecov -i hs48.adj.bed \
-g Drosophila_melanogaster.BDGP6.dna.toplevel.fa.fai \
-scale 0.194269492894 -bg > hs48.adj.bed.bg

bedtools genomecov -i hs72.adj.bed \
-g Drosophila_melanogaster.BDGP6.dna.toplevel.fa.fai \
-scale 0.264335229939 -bg > hs72.adj.bed.bg


bedtools genomecov -i topi.adj.bed \
-g Drosophila_melanogaster.BDGP6.dna.toplevel.fa.fai \
-scale 0.24757873567 -bg > topi.adj.bed.bg



for Input in *.adj.bed.bg
do
	Output=`echo $Input | sed 's/.bed.bg/.bw/'`
	bedGraphToBigWig $Input Drosophila_melanogaster.BDGP6.dna.toplevel.fa.fai $Output
done
