#!/bin/sh

#$ -N Star_idx
#$ -q standard
#$ -cwd
#$ -e ./logs
#$ -o ./logs
#$ -R y
#$ -l h_vmem=10G
#$ -w e
#$ -pe shm 4 # use 4 parrel processors on the same node


module add STAR

STAR --runThreadN 4 \
--runMode genomeGenerate \
--genomeDir /srv/gsfs0/projects/fuller/share/Genome/emsembl_genome_gtf/STAR_indexed \
--genomeFastaFiles /srv/gsfs0/projects/fuller/share/Genome/emsembl_genome_gtf/Drosophila_melanogaster.BDGP6.dna.toplevel.fa \
--sjdbGTFfile /srv/gsfs0/projects/fuller/share/Genome/emsembl_genome_gtf/Drosophila_melanogaster.BDGP6.84.gtf