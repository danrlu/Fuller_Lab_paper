#$ -N merge_peaks
#$ -q standard
#$ -cwd
#$ -e ./logs
#$ -o ./logs
#$ -R y
#$ -l h_vmem=3G
#$ -w e



module add bedtools/2.25.0





cat /srv/gsfs0/projects/fuller/dan/160520_ATAC/160512_J00118_0164_AHCL7NBBXX-L006/trim_PE/macs2_no_ctrl_broad/FF_ATAC3_S3_PE.nsrt.fxm.srt.rmdup__200bp.mrg.broadPeak /srv/gsfs0/projects/fuller/dan/171212_ATAC/trim_PE/macs2_no_ctrl_broad/ATAC-DL3-AGGCAGAA_S3_L001_PE.nsrt.fxm.srt.rmdup.Q20.chr._200bp.mrg.broadPeak | sort -k1,1 -k2,2n | bedtools merge -i - > bam_slop200bp.mrg.broadPeak


cat /srv/gsfs0/projects/fuller/dan/160520_ATAC/160512_J00118_0164_AHCL7NBBXX-L006/trim_PE/macs2_no_ctrl_broad/FF_ATAC8_S8_PE.nsrt.fxm.srt.rmdup__200bp.mrg.broadPeak /srv/gsfs0/projects/fuller/dan/171212_ATAC/trim_PE/macs2_no_ctrl_broad/ATAC-DL9-GCTACGCT_S9_L001_PE.nsrt.fxm.srt.rmdup.Q20.chr._200bp.mrg.broadPeak /srv/gsfs0/projects/fuller/dan/171212_ATAC/trim_PE/macs2_no_ctrl_broad/ATAC-DL12-GTAGAGGA_S12_L001_PE.nsrt.fxm.srt.rmdup.Q20.chr._200bp.mrg.broadPeak | sort -k1,1 -k2,2n | bedtools merge -i - > hs48_slop200bp.mrg.broadPeak



cat /srv/gsfs0/projects/fuller/dan/160520_ATAC/160512_J00118_0164_AHCL7NBBXX-L006/trim_PE/macs2_no_ctrl_broad/FF_ATAC10_S10_PE.nsrt.fxm.srt.rmdup__200bp.mrg.broadPeak /srv/gsfs0/projects/fuller/dan/160520_ATAC/160512_J00118_0164_AHCL7NBBXX-L006/trim_PE/macs2_no_ctrl_broad/FF_ATAC11_S11_S12_PE.nsrt.fxm.srt.rmdup.mrg.srt__200bp.mrg.broadPeak | sort -k1,1 -k2,2n | bedtools merge -i - > hs72_slop200bp.mrg.broadPeak



cat /srv/gsfs0/projects/fuller/dan/160520_ATAC/160512_J00118_0164_AHCL7NBBXX-L006/trim_PE/macs2_no_ctrl_broad/FF_ATAC15_S15_S16_PE.nsrt.fxm.srt.rmdup.mrg.srt__200bp.mrg.broadPeak /srv/gsfs0/projects/fuller/dan/160520_ATAC/160512_J00118_0164_AHCL7NBBXX-L006/trim_PE/macs2_no_ctrl_broad/FF_ATAC19_S19_S20_PE.nsrt.fxm.srt.rmdup.mrg.srt__200bp.mrg.broadPeak /srv/gsfs0/projects/fuller/dan/160520_ATAC/160512_J00118_0164_AHCL7NBBXX-L006/trim_PE/macs2_no_ctrl_broad/FF_ATAC21_S21_S22_PE.nsrt.fxm.srt.rmdup.mrg.srt__200bp.mrg.broadPeak | sort -k1,1 -k2,2n | bedtools merge -i - > aly_slop200bp.mrg.broadPeak



cat /srv/gsfs0/projects/fuller/dan/160520_ATAC/160512_J00118_0164_AHCL7NBBXX-L006/trim_PE/macs2_no_ctrl_broad/FF_ATAC13_S13_S14_PE.nsrt.fxm.srt.rmdup.mrg.srt__200bp.mrg.broadPeak /srv/gsfs0/projects/fuller/dan/160520_ATAC/160512_J00118_0164_AHCL7NBBXX-L006/trim_PE/macs2_no_ctrl_broad/FF_ATAC17_S17_S18_PE.nsrt.fxm.srt.rmdup.mrg.srt__200bp.mrg.broadPeak | sort -k1,1 -k2,2n | bedtools merge -i - > topi_slop200bp.mrg.broadPeak




