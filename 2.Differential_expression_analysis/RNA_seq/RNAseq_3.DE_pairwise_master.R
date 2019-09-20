# Input: 
#     count files with 1st column gene names, 2nd column read count. 1 file for each sample. 
# Output: 
#   1. html of QC plots 
#   2. normalized counts (DE_normalized_counts.txt) 
#   3. statistical test results for significant differential expression (DE_results_all.txt)


suppressWarnings(suppressMessages(library(tidyverse)))
suppressWarnings(suppressMessages(library(magrittr)))

# put the directory
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

all_files=list.files(pattern = '.\\.srt.3_nonMito_protein.txt')
names(all_files)=substr(all_files,1,7)

file_table=as_tibble(names(all_files))%>%dplyr::rename(sampleName=value)
file_table$fileName=all_files

########## change this section before run
###########################
treatment_list=list(c("SHS-1-2","SHS-2-2"),c("SHS-1-3","SHS-2-3"),c("SHS-1-8","SHS-2-8"),c("SHS-1-9","SHS-2-9"))

control_list=list(c("SHS-1-1","SHS-2-1"),c("SHS-1-1","SHS-2-1"),c("SHS-1-3","SHS-2-3"),c("SHS-1-3","SHS-2-3"))

sample_name_list=list('HS48vsBam_RNA','HS72vsBam_RNA','SavsHS72_RNA','AlyvsHS72_RNA')
###########################

for (i in seq_along(treatment_list)) {
    treatment_files=filter(file_table,sampleName %in% treatment_list[[i]])
    treatment_files$condition="treatment"
    
    control_files=filter(file_table,sampleName %in% control_list[[i]])
    control_files$condition="control"
    
    sampleTable=bind_rows(control_files,treatment_files)
    
    sample_name=sample_name_list[[i]]
    
    write_delim(sampleTable, paste0("DE_", sample_name, "_sampleTable.txt"))
    
   rmarkdown::render('RNAseq_DE_pairwise.Rmd', output_file =  paste0("DE_", sample_name, "_pairwise_QC.html"))
}
