# Fuller_paper

Here are the original scripts used to process data for the paper. 

There are places for improvement (mostly, in several steps unzipping/writing out intermediate files was not necessary), and our high performance cluster upgraded from SGE to SLURM somewhere in the middle so it's a mix of job script format. I'm keeping them as they are for record keeping. 

A few notes:
- Put all .fastq files and the scripts into the same folder unless otherwise noted.
- Make sure to change the related parameters before running, especially number of jobs for array jobs. One can also supply these parameters while submitting the job, but having them within the scripts keeps a record.

    SGE version (starts from 1)
    `#$ -t 1-9`

    SLURM version (starts from 0)
    `#SBATCH --array=0-8`


- All multimapping reads were removed for quantification or viewing in genomic browser. I also tried a version (for all experiment) to assign each multimapping reads to 1 randomly selected location and it didn't seem to affect the genes we are interested in. 


