#$ -N Bed_to_BW
#$ -q standard
#$ -cwd
#$ -e ./logs
#$ -o ./logs
#$ -R y
#$ -l h_vmem=6G
#$ -w e
#$ -pe shm 4



########## this was a windy way to load deeptools...
module add python/2.7
export PATH=$HOME/.local/bin/:$PATH
export PYTHONPATH=$HOME/.local/lib/python2.7/site-packages/:$PYTHONPATH

python -V
computeMatrix --version
##########


for Input in *.Q255.chr.bam
do
	Output=`echo $Input | sed 's/.bam/.bw/'`
	bamCoverage -b $Input -o $Output --normalizeUsingRPKM --binSize 10 -p 4
done

# per deeptools manual:
# RPKM (per bin) = number of reads per bin / (number of mapped reads (in millions) * bin length (kb)). 
# CPM (per bin) = number of reads per bin / number of mapped reads (in millions). 
# the difference is the bin length here. Either way simply normalize for the library depth.
