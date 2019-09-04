#$ -N BWA_index
#$ -q standard
#$ -cwd
#$ -e ./logs
#$ -o ./logs
#$ -R y
#$ -l h_vmem=10G
#$ -w e

module add bwa

bwa index Drosophila_melanogaster.BDGP6.dna.toplevel.fa
