#$ -N natac_array
#$ -q standard
#$ -cwd
#$ -e ./logs
#$ -o ./logs
#$ -R y
#$ -l h_vmem=9G
#$ -w e
#$ -pe shm 10
#$ -t 1-9



module add nucleoatac
module add samtools
module list

array=(*_slop200bp.mrg.broadPeak)


Input=${array[$(expr $SGE_TASK_ID - 1)]}

echo $Input
ar=(${Input//_slop200bp.mrg.broadPeak/ })  # // is global replacement. replace all "_PE.nsrt.fxm" with " " a space, and therefore turning ar into an array
Out_prefix=${ar[0]}
echo $Out_prefix

bam=`echo $Input | sed 's/_slop200bp.mrg.broadPeak/.bam/'`
echo $bam
samtools index $bam

nucleoatac run --bed $Input --bam $bam --fasta /srv/gsfs0/projects/fuller/share/Genome/emsembl_genome_gtf/Drosophila_melanogaster.BDGP6.dna.toplevel.fa --out $Out_prefix --cores 10

