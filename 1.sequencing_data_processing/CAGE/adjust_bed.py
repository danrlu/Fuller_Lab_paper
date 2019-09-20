import pandas as pd
import sys

bed_file = sys.argv[1]

df = pd.read_table(bed_file, sep='\t', names=('chrm','start','end','QNAME','score','strand'))
# print bed_file
df.loc[df['strand'] == '-', 'start'] = df['end'] - 1
df.loc[df['strand'] == '+', 'end'] = df['start'] + 1

output_name = bed_file[:-4] + '.adj.bed'
df.to_csv(output_name,sep='\t',header=False,index=False)

print output_name


