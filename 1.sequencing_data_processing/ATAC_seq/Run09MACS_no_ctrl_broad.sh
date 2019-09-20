#$ -N macs
#$ -q standard
#$ -cwd
#$ -e ./logs
#$ -o ./logs
#$ -R y
#$ -l h_vmem=6G
#$ -w e
#$ -t 1-14


module add MACS2/2.1.1
module list


#Input1_list=FF_ATAC`echo $SGE_TASK_ID`_*.rmdup.mrg.srt.Q20.chr.bed
Input_list=(*.Q20.chr.bed)


Input=${Input_list[$(expr $SGE_TASK_ID - 1)]}
echo $Input

Output=`echo $Input | sed 's/.Q20.chr.bed/.Q20.chr./'`
echo $Output

macs2 callpeak \
-t $Input \
-f BED \
-g 1.2e8 \
--broad \
--tsize 75 \
--name $Output \
--outdir macs2_no_ctrl_broad \
-B --nomodel --extsize 100 --shift -50 \
--keep-dup all


