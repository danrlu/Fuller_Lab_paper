#$ -N flagstat_Q20
#$ -q standard
#$ -cwd
#$ -e ./logs
#$ -o ./logs
#$ -R y
#$ -l h_vmem=6G
#$ -w e
#$ -t 1-14


module add samtools/1.5


###################
name_list=(*.Q20.chr.bam) # make a list of all R1.fastq files in the folder

Output2=${name_list[$(expr $SGE_TASK_ID - 1)]} # don't change this line. take the nth ($SGE_TASK_ID-th) file in name_list
###################

samtools flagstat $Output2
