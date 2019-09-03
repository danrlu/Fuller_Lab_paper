## Here are the original scripts used to process raw sequencing data for the paper:

### **Raw sequencing data .fastq -> .bw for genomic browser viewing** 

### **Raw sequencing data .fastq -> read counts for downstream analysis**

There are places for improvement (mostly, in several steps unzipping/writing out intermediate files was not necessary), and our high performance computing cluster upgraded from SGE to SLURM somewhere in the middle of analysis so it's a mix of job script format. I'm keeping them as they are for record keeping. 

#### A few notes:
- Put all .fastq files and the scripts into the same folder unless otherwise noted.
- Make sure to change the related parameters before running, especially number of jobs for array jobs. One can also supply these parameters while submitting the job, but having them within the scripts keeps a record.

    SGE version (starts from 1)
    `#$ -t 1-9`

    SLURM version (starts from 0)
    `#SBATCH --array=0-8`

- PCR duplicates are removed for ATAC-seq and ChIP-seq, if both ends of the read pair map to the exact same genomic positions (I highly recommend paired-end sequencing for them). PCR duplicates are not removed for RNAseq because read pairs mapped to the same genomic location could still flank different splicing variants. **In general it is better to use as much input material, and as few PCR cycles as possible to increase library complexity.**

- CAGE protocol involved no PCR amplification step. 

- All multimapping reads were removed for quantification or viewing in genomic browser. I also tried a version (for all experiment) to assign each multimapping reads to 1 randomly selected location and it didn't seem to affect the genes we are interested in. 

- ChIP-seq I started from .bam generated from published results, but to get to the .bam is totally identical to ATAC-seq. The only difference is after getting .bam file, ATAC-seq cares about the end of the reads (accessible region), but ChIP-seq cares about the entire regions the fragment covers (between the read pairs), so the steps to generate .bw for viewing, and MACS2 calling peaks is different. 
