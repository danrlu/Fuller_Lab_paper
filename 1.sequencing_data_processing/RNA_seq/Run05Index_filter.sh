#!/bin/bash

#$ -N Index_filter
#$ -q standard
#$ -cwd
#$ -e ./logs
#$ -o ./logs
#$ -R y
#$ -l h_vmem=12G
#$ -w e
#$ -t 1-9

module add igvtools/2.3.82
module add samtools/1.5
module list

cd trim_PE

################
# in line 11 (#$ -t 1-1), if have more than 1 libraries, for example, 3 libraries (each have R1 and R2 for paired end) change 1-1 to 1-3

chrm_size=/srv/gsfs0/projects/fuller/share/Genome/emsembl_genome_gtf/Drosophila_melanogaster.BDGP6.dna.toplevel.fa.fai # the .fai file in the genome folder

name_list=(*.sortedByCoord.out.bam)
################


Input=${name_list[$(expr $SGE_TASK_ID - 1)]}
echo $Input

Output_tdf=`echo $Input | sed 's/.bam/.tdf/'`

Output_flagstat=`echo $Input | sed 's/.bam/.flagstat/'`

Output_idxstat=`echo $Input | sed 's/.bam/.idxstat/'`

samtools index $Input   # index the bam file for fast access

samtools flagstat $Input > $Output_flagstat  # statistics on the bam file

samtools idxstats $Input > $Output_idxstat   # statistics on the bam file

# igvtools count $Input $Output_tdf $chrm_size   # convert to tdf file



Output0=`echo $Input | sed 's/.bam/.Q255.chr.bam/'`

samtools view -b -q 255 $Input 2L 2R 3L 3R 4 X Y > $Output0
samtools index $Output0

