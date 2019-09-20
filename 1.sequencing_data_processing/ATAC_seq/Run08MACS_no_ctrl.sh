#$ -N macs
#$ -q standard
#$ -cwd
#$ -e ./logs
#$ -o ./logs
#$ -R y
#$ -l h_vmem=6G
#$ -w e
#$ -t 1-9

module add MACS2
module list
module add bedtools/2.25.0


bam_list=(*.bam)

Input=${bam_list[$(expr $SGE_TASK_ID - 1)]}

Output2=`echo $Input | sed 's/.bam/.bed/'`
echo $Output2
bedtools bamtobed -i $Input > $Output2

Output3=`echo $Output2 | sed 's/.bed//'`
echo $Output3

macs2 callpeak \
-t $Output2 \
-f BED \
-g 1.2e8 \
--name $Output3 \
--outdir macs2_no_ctrl \
-B --nomodel --shift -50 --extsize 100 \
--keep-dup all


