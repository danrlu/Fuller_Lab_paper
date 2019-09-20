#!/bin/bash
#SBATCH -J index   # name of the job
#SBATCH --mem=50G     # reserve 50G (per processor) of memory for the job
#SBATCH -t 12:0:0    # the job will be killed after 12hr if still not completed
#SBATCH -p batch    # the queue to send it to. Keep this as it is.
#SBATCH --account=mtfuller   # SUNID of your PI
#SBATCH --cpus-per-task=4

cd $SLURM_SUBMIT_DIR     # all the output of the file will be in the same directory as the .sh script


module add STAR
module add samtools

module list

mkdir -p STAR_index_UCSC



STAR --runThreadN 4 \
--runMode genomeGenerate \
--genomeDir STAR_index_UCSC \
--genomeFastaFiles /labs/mtfuller/share/Genome_UCSC_Aug_2014_BDGP_Release6/dm6_UCSC.fa 
# STAR index for mapping

#samtools faidx $fasta
