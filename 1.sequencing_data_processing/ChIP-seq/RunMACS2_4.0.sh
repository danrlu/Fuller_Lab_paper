#$ -N macs_predictd
#$ -q standard
#$ -cwd
#$ -e ./logs
#$ -o ./logs
#$ -R y
#$ -l h_vmem=6G
#$ -w e


module add MACS2
module list




macs2 callpeak \
-t AlyHA-ChIP-WT-03-TTAGGCAT_S3_R1.Q20.chr.bam \
-c AlyHA-Input-WT-03-ATCACGTT_S1_R1.Q20.chr.bam \
-f BAM \
-g 1.2e8 \
--tsize 75 \
--name AlyHA-WT \
--outdir macs2 \
--keep-dup auto \
--nomodel --extsize 220 \
--call-summits \
-B
