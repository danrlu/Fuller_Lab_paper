#$ -N slop
#$ -q standard
#$ -cwd
#$ -e ./logs
#$ -o ./logs
#$ -R y
#$ -l h_vmem=10G
#$ -w e



module add bedtools/2.25.0


for Input in *_peaks.broadPeak
do
	Output=`echo $Input | sed 's/peaks.broadPeak/200bp.broadPeak/'`
	bedtools slop -i $Input -g /srv/gsfs0/projects/fuller/share/Genome/emsembl_genome_gtf/Drosophila_melanogaster.BDGP6.dna.toplevel.fa.fai -b 200 > $Output

	Output2=`echo $Input | sed 's/peaks.broadPeak/200bp.mrg.broadPeak/'`
	bedtools merge -i $Output > $Output2
done
