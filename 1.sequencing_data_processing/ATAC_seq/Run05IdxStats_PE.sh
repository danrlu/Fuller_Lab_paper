#$ -N IdxStat_PE
#$ -q standard
#$ -cwd
#$ -e ./logs
#$ -o ./logs
#$ -R y
#$ -l h_vmem=6G
#$ -w e
#$ -t 1-14


module add samtools/1.5


#####################
# in line 9 (#$ -t 1-1), if have more than 1 libraries, for example, 3 libraries (each have R1 and R2 for paired end) change 1-1 to 1-3

name_list=(*_PE.nsrt.fxm.srt.rmdup.bam) # make a list of all R1.fastq files in the folder

Input1=${name_list[$(expr $SGE_TASK_ID - 1)]} # don't change this line. take the nth ($SGE_TASK_ID-th) file in name_list
#####################

echo $Input1
samtools idxstats $Input1



