#!/bin/bash
#$ -cwd
#$ -l h_vmem=4G
#$ -pe serial 8
#$ -S "/bin/bash"

module load bwa/x86_64/0.7.17
module load samtools/x86_64/1.15.1
module load samblaster/x86_64/0.1.26

bwa index Ccl_V1_assembly.fasta

bwa mem -t 8 Ccl_V1_assembly.fasta ERR16730035/ERR16730035_1.fastq.gz ERR16730035/ERR16730035_2.fastq.gz | samblaster --excludeDups --addMateTags --maxSplitCount 2 --minNonOverlap 20 | samtools view -S -b - > Library1.bam