#!/bin/bash
#SBATCH -J CAGEr   # name of the job
#SBATCH --mem-per-cpu=20G     # reserve 30G (per processor) of memory for the job
#SBATCH -t 12:0:0    # the job will be killed after 24hr if still not completed
#SBATCH -p batch    # the queue to send it to. Keep this as it is.
#SBATCH --account=mtfuller   # SUNID of your PI
#SBATCH --cpus-per-task=8


cd $SLURM_SUBMIT_DIR

module add r/3.4.4

Rscript CAGEr.R
