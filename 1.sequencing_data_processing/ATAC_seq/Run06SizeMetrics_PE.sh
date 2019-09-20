#$ -N SizeMetrics
#$ -q standard
#$ -cwd
#$ -e ./logs
#$ -o ./logs
#$ -R y
#$ -l h_vmem=6G
#$ -l h_stack=1G
#$ -w e
#$ -t 1-14


# module add samtools/1.5
module add java
module add R/3.3.1
# module add picard-tools


#####################
# in line 9 (#$ -t 1-1), if have more than 1 libraries, for example, 3 libraries (each have R1 and R2 for paired end) change 1-1 to 1-3

name_list=(*.fxm.srt.bam) # make a list of all R1.fastq files in the folder

Output1=${name_list[$(expr $SGE_TASK_ID - 1)]} # don't change this line. take the nth ($SGE_TASK_ID-th) file in name_list
#####################



Output2=`echo $Output1 | sed 's/.bam/_InsertSize.pdf/'`
echo $Output2

Output3=`echo $Output1 | sed 's/.bam/_InsertSize.txt/'`
echo $Output3

java -XX:MaxHeapSize=2G -XX:ParallelGCThreads=2 -jar /srv/gsfs0/software/picard-tools/1.129/picard.jar CollectInsertSizeMetrics INPUT=$Output1 HISTOGRAM_FILE=$Output2 OUTPUT=$Output3 VALIDATION_STRINGENCY=LENIENT
# if the .bam contains unmapped reads, will incur: SAM validation error: ERROR: Record 5590, Read name NS500615:210:H5FHTAFXX:2:11208:2680:1075, MAPQ should be 0 for unmapped read. 
# with VALIDATION_STRINGENCY=LENIENT, the error will be ignored







#####################
# in line 9 (#$ -t 1-1), if have more than 1 libraries, for example, 3 libraries (each have R1 and R2 for paired end) change 1-1 to 1-3

name_list=(*.rmdup.bam) # make a list of all R1.fastq files in the folder

Output1=${name_list[$(expr $SGE_TASK_ID - 1)]} # don't change this line. take the nth ($SGE_TASK_ID-th) file in name_list
#####################



Output2=`echo $Output1 | sed 's/.bam/_InsertSize.pdf/'`
echo $Output2

Output3=`echo $Output1 | sed 's/.bam/_InsertSize.txt/'`
echo $Output3

java -XX:MaxHeapSize=2G -XX:ParallelGCThreads=2 -jar /srv/gsfs0/software/picard-tools/1.129/picard.jar CollectInsertSizeMetrics INPUT=$Output1 HISTOGRAM_FILE=$Output2 OUTPUT=$Output3 VALIDATION_STRINGENCY=LENIENT
# if the .bam contains unmapped reads, will incur: SAM validation error: ERROR: Record 5590, Read name NS500615:210:H5FHTAFXX:2:11208:2680:1075, MAPQ should be 0 for unmapped read. 
# with VALIDATION_STRINGENCY=LENIENT, the error will be ignored









#####################
# in line 9 (#$ -t 1-1), if have more than 1 libraries, for example, 3 libraries (each have R1 and R2 for paired end) change 1-1 to 1-3

name_list=(*.Q20.chr.bam) # make a list of all R1.fastq files in the folder

Output1=${name_list[$(expr $SGE_TASK_ID - 1)]} # don't change this line. take the nth ($SGE_TASK_ID-th) file in name_list
#####################



Output2=`echo $Output1 | sed 's/.bam/_InsertSize.pdf/'`
echo $Output2

Output3=`echo $Output1 | sed 's/.bam/_InsertSize.txt/'`
echo $Output3

java -XX:MaxHeapSize=2G -XX:ParallelGCThreads=2 -jar /srv/gsfs0/software/picard-tools/1.129/picard.jar CollectInsertSizeMetrics INPUT=$Output1 HISTOGRAM_FILE=$Output2 OUTPUT=$Output3 VALIDATION_STRINGENCY=LENIENT
# if the .bam contains unmapped reads, will incur: SAM validation error: ERROR: Record 5590, Read name NS500615:210:H5FHTAFXX:2:11208:2680:1075, MAPQ should be 0 for unmapped read. 
# with VALIDATION_STRINGENCY=LENIENT, the error will be ignored

