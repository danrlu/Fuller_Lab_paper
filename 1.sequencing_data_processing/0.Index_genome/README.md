## Index the genome for RNA-seq, ATAC-seq, ChIP-seq, etc.

**Only need to do this once for each genome and annotation.**

#### 1. download the genomic sequence (.fa) and the annotation file (.gtf, or .gff3, they contain the same info but in slightly different format).
Go to Ensembl ftp:   

ftp://ftp.ensembl.org/pub/

in the current_fasta and current_gtf folder, look for the right species
- In general, use all the avaialable sequence with no masks for mapping. During read mapping, if the aligner could not map a read to the genome due to the corresponding sequence being masked, it will try to find somewhere else to map it to. 
- For fly, I use \*.dna.toplevel\*.fa, but for mammals that contains all patches and alt contigs and will be too big (at least STAR will not be able to index them...). Use \*.dna_primary.assembly\*.fa
- DNA sequence is the same from all databases, the chromosome names and annotation varies. So always **use sequence and annotation from the same source** so the chromosome names match. Ensembl is well-organized so I stick with it.
- The annotation file is usually only needed for counting reads per gene, which STAR does on the fly while mapping. It takes both .gtf and .gff3


#### 2. index the genome
ftp upload the .fasta and .gtf in the same folder, and create a sub-folder called 'logs'. On command line, navigate to the genome folder
```bash
qsub Run_BWA_indexing.sh
qsub RunStarIndex_wGTF.sh
qsub Run_samtools_index.sh
```
- This creates index for BWA (DNA originated reads, ChIP-seq, ATAC-seq), STAR (RNA originated reads RNA-seq etc), and samtools will create the .fai file which is the chromosome size file or genome file (-g in bedtools) a lot of pacakges require for later analysis.
- only need to do this once... until STAR updated and required index from a newer version...


---------------
last used 6/12/16 on SGE

BWA/0.7.10

STAR/2.5.1b

samtools/??
