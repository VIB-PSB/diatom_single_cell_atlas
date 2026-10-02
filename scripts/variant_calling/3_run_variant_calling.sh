
#!/bin/bash
#$ -cwd
#$ -l h_vmem=5G
#$ -pe serial 2
#$ -S "/bin/bash"

module load samtools/x86_64/1.15.1
module load bcftools/x86_64/1.15.1

# Four steps of variant calling: 
# Generate genotype likelihoods (mpileup): max depth of 1000, minimum mapping quality 20, minimum base quality 20
# Call SNPs and Indels (call)
# Filter

MINDEP=5 # Minimum depth
MAXDEP=500 # Maxdepth

bcftools mpileup -d 1000 -q 20 -Q 20 -a DP,SP,DP4 -f Ccl_V1_assembly.fasta -b filelist.txt \
    | bcftools call -m -O v -g 8  \
    | bcftools filter -saFilter -g3 -G10 -e'%QUAL<10 || (AC<2 && %QUAL<15) || FMT/DP<'$MINDEP' || ( GT="0/1" && INFO/DP4[0]+INFO/DP4[1] < 2  ) ' - \
    | bcftools filter -sHighDepth -e '%MAX(INFO/DP) > '$MAXDEP'' \
    > Library1.flt.vcf
    
# Filter to keep only the non-variant sites
bcftools view -e 'ALT="."' Library1.flt.vcf > Library1.flt_only_variant.vcf

