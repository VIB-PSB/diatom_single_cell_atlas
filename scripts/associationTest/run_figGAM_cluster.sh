#!/bin/bash
#$ -cwd
#$ -l h_vmem=24G
#$ -pe serial 2

cd /scratch/diatomcomp/scRNA_seq/server_scripts/

module load R/x86_64/4.1.3

Rscript fitGAM_MT.R 
