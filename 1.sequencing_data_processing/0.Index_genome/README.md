## Index the genome for RNA-seq, ATAC-seq, ChIP-seq, etc.

**Only need to do this once for each genome and annotation.**

#### 1. download the genomic sequence (.fa) and the annotation file (.gtf, or .gff3, they contain the same info but in slightly different format).
Go to Ensembl ftp:   ftp://ftp.ensembl.org/pub/

in the current_fasta and current_gtf folder, look for the right species
- Regardless of downstream applications, always use ALL the avaialable sequence with no masks (\*.dna.toplevel\*.fa) for mapping. During read mapping, if the aligner could not map a read to the genome due to the corresponding sequence being masked, it will try to find somewhere else to map it to.
- DNA sequence is the same from all databases, the chromosome names and annotation varies. Ensembl is well-organized so I stick with it.


#### 2. index the genome
ftp upload the .fasta and .gtf in the same folder, and create a sub-folder called 'logs'. On command line, navigate to the genome folder
```bash
qsub Run_BWA_indexing.sh
qsub RunStarIndex_wGTF.sh
qsub Run_samtools_index.sh
```
- This creates index for BWA (DNA originated reads, ChIP-seq, ATAC-seq), STAR (RNA originated reads RNA-seq etc), and samtools will create the .fai file which is the chromosome size file or genome file (-g in bedtools) a lot of pacakges require for later analysis.
- only need to do this once... until STAR updated and required index from a newer version...
