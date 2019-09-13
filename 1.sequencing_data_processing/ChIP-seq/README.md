## ChIP-seq 

I started from .bam generated from published results, but from raw reads .fastq to get to the .bam is totally identical to ATAC-seq. The only difference is after getting .bam file, ATAC-seq cares about the end of the reads (accessible region), but ChIP-seq cares about the entire regions the fragment covers (between the read pairs), so the steps to generate .bw for viewing, and MACS2 calling peaks is different.

#### call peaks with MACS2
Tried using `-m` to build the model with different parameters, MACS2 gave an error: Too few paired peaks. So went without. 
```bash
qsub RunMACS2_4.0.sh
```


#### convert to .bw for genomic browser
```bash
qsub RunBamtoBW_bin1_properChIP.sh
```

----------
call peak last used 3/1/18 on SGE

MACS2/2.1.1

BamtoBW last used 2/3/19 on SLURM

plotly/2.0.0

deepTools/3.1.0

gcc/5.2.0

cython/0.28.5

python/2.7(default)

pysam/0.15.0.1
