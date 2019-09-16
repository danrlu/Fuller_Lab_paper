## Differential expression (DE) analysis for RNA-seq, ATAC-seq, ChIP-seq and CAGE

Very good explanations by Harold Pimentel (author of Sleuth):

Betweensample normalization: https://haroldpimentel.wordpress.com/2014/12/08/inrnaseq22betweensamplenormalization/

Withinsample normalization: https://haroldpimentel.wordpress.com/2014/05/08/whatthefpkmareviewrnaseqexpressionunits/



#### To see changes of the same gene/genomic region across different conditions
The input files for all DE anlaysis is **read counts for genomic regions** for each sample. In general replicates for each conditions is a MUST, I think the only time you may get away without replicates is if you have time course experiment and do spline fit to see the trend.

1. To obtain the read count files, one first need **genomic regions (aka features) to count the reads** in. 
  - For RNA-seq, the regions are usualy genes, defined in .gtf and .gff3 files.
  - For ATAC-seq/ChIP-seq, the regions are usually open chromatin/ChIP peaks called by MACS2. **One set of common regions** needs to be used for all samples, so peaks called from different samples needs to be merged first. Here they are combined and overlapping peaks merged into 1. 

    `cat *.narrowPeak | sort -k1,1 -k2,2n | bedtools merge -i - > all.narrowPeak`
 
    - Do NOT use peaks called from 1 condition. This is equivalent of doing DE with a selected set of genes that will strongly bias the DE results.
    - The more samples there are, the wider the merged peaks tend to be. 
    - Alternatively for ATAC-seq, a region of defined width can be used, such as +/- X bp from the gene TSS or +/- X bp from the peak summits. I usually try different ways and see whether the conclusions stay the same.
    
- For CAGE, the regions are TSS clusters built and then combined by CAGEr to become consensus clusters.
  
2. To count reads in each region, typical solution is HTSeq. It was really slow in my hands, so instead:
  - For RNA-seq, STAR does counting on the fly while mapping with  `
  
  
#### To compare different genes/genomic regions
Just want to add a note for this, that 


