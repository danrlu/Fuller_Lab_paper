#$ -N trim_PE
#$ -q standard
#$ -cwd
#$ -e ./logs
#$ -o ./logs
#$ -l h_vmem=12G
#$ -w e
#$ -t 1-14

module load perl-scg/5.24.0
module load trim_galore/0.4.1
module add cutadapt/1.8.1
module list

mkdir -p trim_PE # make directory for output

#####################
# in line 8 (#$ -t 1-1), if have more than 1 libraries, for example, 3 libraries (each have R1 and R2 for paired end) change 1-1 to 1-3

name_list=(*_R1_*.fastq) # make a list of all fastq files in the folder which has "R1" (read 1) in file name
# name_list=(a.fastq b.fastq) # or write a full list of fastq files

Input1=${name_list[$(expr $SGE_TASK_ID - 1)]} # don't change this line
# take the nth ($SGE_TASK_ID-th) file in name_list

Input2=`echo $Input1 | sed 's/_R1_/_R2_/'`
# replace R1 in name of read 1 to generate file name of read 2
#####################


trim_galore --quality 20 --nextera --stringency 1 --length 20 --paired_end $Input1 $Input2 --output_dir trim_PE/



