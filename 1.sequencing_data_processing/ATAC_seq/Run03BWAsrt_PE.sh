#$ -N bwa
#$ -q standard
#$ -cwd
#$ -e ./logs
#$ -o ./logs
#$ -R y
#$ -l h_vmem=15G
#$ -w e
#$ -t 1-14


module add bwa/0.7.10
module add samtools/1.5

cd trim_PE

#####################
# in line 9 (#$ -t 1-1), if have more than 1 libraries, for example, 3 libraries (each have R1 and R2 for paired end) change 1-1 to 1-3

genome=/srv/gsfs0/projects/fuller/share/Genome/emsembl_genome_gtf/Drosophila_melanogaster.BDGP6.dna.toplevel.fa
echo $genome


name_list=(*_R1_001_val_1.fq) # make a list of all R1.fastq files in the folder

Input1=${name_list[$(expr $SGE_TASK_ID - 1)]} # don't change this line. take the nth ($SGE_TASK_ID-th) file in name_list

Input2=`echo $Input1 | sed 's/_R1_001_val_1/_R2_001_val_2/'`   # replace R1 in name of read 1 to generate file name of read 2

OutputSam=`echo $Input1 | sed 's/_R1_001_val_1.fq/_PE.sam/'`
#####################



Output1=`echo $Input1 | sed 's/.fq/.sai/'`
Output2=`echo $Input2 | sed 's/.fq/.sai/'`
echo $Output1
echo $Output2
echo $Input1
echo $Input2
bwa aln $genome $Input1 > $Output1
bwa aln $genome $Input2 > $Output2


echo $OutputSam

bwa sampe $genome $Output1 $Output2 $Input1 $Input2 > $OutputSam



OutputTemp=`echo $OutputSam | sed 's/.sam/.temp/'`
echo $OutputTemp

Output3=`echo $OutputSam | sed 's/.sam/.nsrt.bam/'`
echo $Output3
samtools sort -O bam -o $Output3 -n -T $OutputTemp $OutputSam

Output4=`echo $Output3 | sed 's/.bam/.fxm.bam/'`
echo $Output4
samtools fixmate -O bam $Output3 $Output4
## don't remove unmapped reads here (-r), picard will complain pair info is incorrect

Output5=`echo $Output4 | sed 's/.bam/.srt.bam/'`
echo $Output5
samtools sort -O bam -o $Output5 -T $OutputTemp $Output4

