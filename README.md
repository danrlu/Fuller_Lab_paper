# Scripts for the paper from D. Lu, H.S. Sin, C. Lu and M. T. Fuller. GEO: GSE145975
## == tutorials on how to reproduce the data pre-processing from the paper

  - I'm keeping the scripts as they are for record keeping, despite the following caveats:

  - ... in several steps unzipping/writing out intermediate files was not necessary. I did it to make sure the intermediates were what I thought they were, but they consumes storage space.
  
  - ... our high performance computing cluster upgraded from SGE to SLURM somewhere in the middle of analysis so it's a mix of job script format.  
  
  - ... normalization for bigwig in ATAC-seq and CAGE used 10x of RPM instead of RPM to avoid data range smaller than 1.
  
**Data** contains the gene lists and associated .bed files for CAGE clusters.

**1.sequencing_data_processing (Bash)** includes scripts that process raw sequencing data (RNA-seq, ATAC-seq, CAGE) to (a) files for viewing in genomic browser, and (b) raw read counts to downstream analysis. 

**2.Differential_experssion_analysis (R)** includes scripts that normalize read counts across samples and do differential expression. 

**3.data_integrative_analysis (R)** includes scripts that integrates all available data to define gene groups and assing CAGE clusters to genes. 

