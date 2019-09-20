# Scripts for the paper from D. Lu, H. Sin, C. Lu and M. T. Fuller.

  - I'm trying to have all the scripts here to reproduce the data analysis. 

  - There are places for improvement (mostly, in several steps unzipping/writing out intermediate files was not necessary), and 
  
  - Our high performance computing cluster upgraded from SGE to SLURM somewhere in the middle of analysis so it's a mix of job script format. I'm keeping them as they are for record keeping. 
  
**1.sequencing_data_processing** includes scripts that process raw sequencing data (RNA-seq, ATAC-seq, CAGE) to (a) files for viewing in genomic browser, and (b) raw read counts to downstream analysis.

**2.Differential_experssion_analysis** includes scripts that normalize read counts across samples and do differential expression.

**3.data_integrative_analysis** includes scripts that integrates all available data to define gene groups. 

**4.sequencing_data_heatmap** includes scripts that takes processed sequencing data in 1.a and gene groups from 2. to plot genomic heatmaps with deepTools

**5.motif_analysis** includes scripts for MEME suites

**6.motifs_plots** includes scripts for seqPattern plots
