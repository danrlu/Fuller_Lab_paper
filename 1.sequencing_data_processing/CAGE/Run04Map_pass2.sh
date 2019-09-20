#!/bin/bash
#SBATCH -J Map_pass2   # name of the job
#SBATCH --mem-per-cpu=20G     # reserve 30G (per processor) of memory for the job
#SBATCH -t 12:0:0    # the job will be killed after 24hr if still not completed
#SBATCH -p batch    # the queue to send it to. Keep this as it is.
#SBATCH --account=mtfuller   # SUNID of your PI
#SBATCH --cpus-per-task=4
#SBATCH --array=0-7


cd $SLURM_SUBMIT_DIR     # all the output of the file will be in the same directory as the .sh script



module add STAR
module list

cd trim_SE  # change directory to where trimmed reads are


####################
# change number of libraries in line 8 (#SBATCH --array=0-9), note counting starts from 0 now!

star_index=../STAR_index_UCSC  # indexed genome location

name_list=(*_trimmed.fq) # make a list of all R1.fastq files in the folder

Input1_trimmed=${name_list[$SLURM_ARRAY_TASK_ID]} # don't change this. take the nth ($SGE_TASK_ID-th) file in name_list

custom_gtf=../cuffcmp.combined.ucsc.gtf
#####################


#junction=`echo star_pass1/*SJ.out.tab`  # a list of splice junctions detected by STAR from pass 1
pass2_prefix=${Input1_trimmed%.*}_ # prefix for pass 2 outputs


STAR --runThreadN 4 \
--runMode alignReads \
--genomeDir $star_index \
--alignIntronMax 100000 \
--alignMatesGapMax 100000 \
--outFilterMismatchNoverLmax 0.04 \
--alignEndsType Local \
--sjdbGTFfile $custom_gtf \
--alignSJoverhangMin 25 \
--readFilesIn $Input1_trimmed \
--outSAMtype BAM SortedByCoordinate \
--limitBAMsortRAM 10000000000 \
--outSAMmapqUnique 255 \
--outFileNamePrefix $pass2_prefix




# --quantMode GeneCounts \   # count reads per gene after mapping. Only reads overlap with only one gene will be counted.
# --outSAMtype BAM SortedByCoordinate \  # output type is bam sorted by genome coordinate. STAR sorting is much more efficient than samtools. 
# --outSAMmapqUnique 255 \ # only keep uniquely mapped reads in the output
# --limitBAMsortRAM 10000000000 \  # RAM for sort bam in bytes, the default is usually not enough

