
#!/bin/bash
#$ -cwd
#$ -l h_vmem=5G
#$ -pe serial 2
#$ -S "/bin/bash"

module load samtools/x86_64/1.15.1
module load bcftools/x86_64/1.15.1

# Sort and index bam file
samtools sort Library1.bam -o Library1_sorted.bam
samtools index Library1_sorted.bam
