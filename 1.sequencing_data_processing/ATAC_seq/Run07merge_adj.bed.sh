#$ -N merge_ATAC
#$ -q extended
#$ -cwd
#$ -e ./logs
#$ -o ./logs
#$ -R y
#$ -l h_vmem=12G
#$ -w e


#.adj.bed, bam, 48hr, 72hr, aly, topi from both hi-seq

cat /srv/gsfs0/projects/fuller/dan/160520_ATAC/160512_J00118_0164_AHCL7NBBXX-L006/trim_PE/FF_ATAC3_S3_PE.nsrt.fxm.srt.rmdup.Q20.chr.adj.bed /srv/gsfs0/projects/fuller/dan/171212_ATAC/trim_PE/ATAC-DL3-AGGCAGAA_S3_L001_PE.nsrt.fxm.srt.rmdup.Q20.chr.adj.bed | sort -k1,1 -k2,2n > bam.adj.bed


cat /srv/gsfs0/projects/fuller/dan/160520_ATAC/160512_J00118_0164_AHCL7NBBXX-L006/trim_PE/FF_ATAC8_S8_PE.nsrt.fxm.srt.rmdup.Q20.chr.adj.bed /srv/gsfs0/projects/fuller/dan/171212_ATAC/trim_PE/ATAC-DL9-GCTACGCT_S9_L001_PE.nsrt.fxm.srt.rmdup.Q20.chr.adj.bed /srv/gsfs0/projects/fuller/dan/171212_ATAC/trim_PE/ATAC-DL12-GTAGAGGA_S12_L001_PE.nsrt.fxm.srt.rmdup.Q20.chr.adj.bed | sort -k1,1 -k2,2n > hs48.adj.bed

cat /srv/gsfs0/projects/fuller/dan/160520_ATAC/160512_J00118_0164_AHCL7NBBXX-L006/trim_PE/FF_ATAC10_S10_PE.nsrt.fxm.srt.rmdup.Q20.chr.adj.bed /srv/gsfs0/projects/fuller/dan/160520_ATAC/160512_J00118_0164_AHCL7NBBXX-L006/trim_PE/FF_ATAC11_S11_S12_PE.nsrt.fxm.srt.rmdup.mrg.srt.Q20.chr.adj.bed | sort -k1,1 -k2,2n > hs72.adj.bed



cat /srv/gsfs0/projects/fuller/dan/160520_ATAC/160512_J00118_0164_AHCL7NBBXX-L006/trim_PE/FF_ATAC15_S15_S16_PE.nsrt.fxm.srt.rmdup.mrg.srt.Q20.chr.adj.bed /srv/gsfs0/projects/fuller/dan/160520_ATAC/160512_J00118_0164_AHCL7NBBXX-L006/trim_PE/FF_ATAC19_S19_S20_PE.nsrt.fxm.srt.rmdup.mrg.srt.Q20.chr.adj.bed /srv/gsfs0/projects/fuller/dan/160520_ATAC/160512_J00118_0164_AHCL7NBBXX-L006/trim_PE/FF_ATAC21_S21_S22_PE.nsrt.fxm.srt.rmdup.mrg.srt.Q20.chr.adj.bed | sort -k1,1 -k2,2n > aly.adj.bed


cat /srv/gsfs0/projects/fuller/dan/160520_ATAC/160512_J00118_0164_AHCL7NBBXX-L006/trim_PE/FF_ATAC13_S13_S14_PE.nsrt.fxm.srt.rmdup.mrg.srt.Q20.chr.adj.bed /srv/gsfs0/projects/fuller/dan/160520_ATAC/160512_J00118_0164_AHCL7NBBXX-L006/trim_PE/FF_ATAC17_S17_S18_PE.nsrt.fxm.srt.rmdup.mrg.srt.Q20.chr.adj.bed | sort -k1,1 -k2,2n > topi.adj.bed 



