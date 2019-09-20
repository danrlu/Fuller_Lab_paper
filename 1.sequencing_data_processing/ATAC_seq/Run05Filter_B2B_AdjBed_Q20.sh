#$ -N B2B
#$ -q standard
#$ -cwd
#$ -e ./logs
#$ -o ./logs
#$ -R y
#$ -l h_vmem=9G
#$ -w e
#$ -t 1-14

module add samtools/1.5
module add bedtools/2.25.0
module add python/2.7


#####################
# in line 9 (#$ -t 1-1), if have more than 1 libraries, for example, 3 libraries (each have R1 and R2 for paired end) change 1-1 to 1-3

name_list=(*.rmdup.bam) # make a list of all R1.fastq files in the folder

Input1=${name_list[$(expr $SGE_TASK_ID - 1)]} # don't change this line. take the nth ($SGE_TASK_ID-th) file in name_list
#####################


echo $Input1
Output1=`echo $Input1 | sed 's/.bam/.Q20.chr.bam/'`
echo $Output1

samtools index $Input1  # has to index before -view
samtools view -b -q 20 $Input1 2L 2R 3L 3R 4 X Y > $Output1
samtools index $Output1


Output2=`echo $Output1 | sed 's/.bam/.bed/'`
echo $Output2
bedtools bamtobed -i $Output1 > $Output2

python adjust_bed.py $Output2



