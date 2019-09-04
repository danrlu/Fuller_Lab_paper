#!/bin/bash

#$ -N CountTable
#$ -q standard
#$ -cwd
#$ -e ./logs
#$ -o ./logs
#$ -l h_vmem=1G
#$ -w e

cd trim_PE

touch sampleTable.txt    # create a file
echo sampleName,fileName,condition > sampleTable.txt  # write header to the file


for file in *ReadsPerGene.out.tab    # go through each count file
do
    awk 'NR > 4 { print }' $file | sort -k1 - | awk -v strand=3 -v OFS='\t' '{print $1, $strand}' > ${file}.srt.${1}.txt
    echo ${file}.srt.${1}.txt,${file}.srt.${1}.txt,control >> sampleTable.txt
done

