#!/bin/bash
#SBATCH -J trim_SE   # name of the job
#SBATCH --mem=20G     # reserve 10G (per processor) of memory for the job
#SBATCH -t 12:0:0    # the job will be killed after 24hr if still not completed
#SBATCH -p batch    # the queue to send it to. Keep this as it is.
#SBATCH --account=mtfuller   # SUNID of your PI
#SBATCH --array=0-7


cd $SLURM_SUBMIT_DIR     # all the output of the file will be in the same directory as the .sh script


module purge
unset PERL5LIB
unset PYTHONPATH
module load anaconda
source activate trimgalore_0.4.5

module list

mkdir -p trim_SE # make directory for output


#####################
# in line 7 (#SBATCH --array=0-9), note counting starts from 0 now!, if have more than 1 libraries, for example, 3 libraries (each have R1 and R2 for paired end) change 0-10 to 0-2.

name_list=(*.fastq) # make a list of all fastq files in the folder which has "R1" (read 1) in file name
# name_list=(a.fastq b.fastq) # or write a full list of fastq files

Input1=${name_list[$SLURM_ARRAY_TASK_ID]} # don't change this line
# take the nth ($SGE_TASK_ID-th) file in name_list


#####################


trim_galore --quality 20 --stringency 1 --three_prime_clip_R2 2 $Input1 --length 30 --output_dir trim_SE/

