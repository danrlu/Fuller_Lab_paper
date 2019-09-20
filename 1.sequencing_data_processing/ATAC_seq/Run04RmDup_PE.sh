#$ -N dup
#$ -q standard
#$ -cwd
#$ -e ./logs
#$ -o ./logs
#$ -R y
#$ -l h_vmem=12G
#$ -l h_stack=256M
#$ -w e
#$ -t 1-14


module add java

###################
name_list=(*_PE.nsrt.fxm.srt.bam) # make a list of all R1.fastq files in the folder

Output2=${name_list[$(expr $SGE_TASK_ID - 1)]} # don't change this line. take the nth ($SGE_TASK_ID-th) file in name_list
###################


echo $Output2
Output3=`echo $Output2 | sed 's/.bam/.rmdup.bam/'`
echo $Output3
Outputmetrics=`echo $Output3 | sed 's/.bam/.metrics.txt/'`
java -XX:MaxHeapSize=1G -jar /srv/gsfs0/software/picard-tools/1.130/picard.jar MarkDuplicates INPUT=$Output2 OUTPUT=$Output3 REMOVE_DUPLICATES=true METRICS_FILE=$Outputmetrics VALIDATION_STRINGENCY=LENIENT

