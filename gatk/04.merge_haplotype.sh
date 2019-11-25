#!/bin/bash
#BSUB -J hybrid_job_name      # job name
#BSUB -n 1                   # number of tasks in job
#BSUB -q Q104C512G_X4_1              # queue
#BSUB -e errors.%J     # error file name in which %J is replaced by the job ID
#BSUB -o output.%J     # output file name in which %J is replaced by the job ID

#BQSR

set -euxo pipefail

ref=/ds3200_1/users_root/yitingshuang/lh/fragaria/buzzo/gatk/ref/F_vesca_H4_V4.1.fasta
GATK_HOME=/ds3200_1/users_root/yitingshuang/lh/bin/gatk-4.1.4.0

#genotype gvcf files
cd /ds3200_1/users_root/yitingshuang/lh/fragaria/buzzo/gatk/input
gvcfFile=total.g.vcf
vcfFile=total.vcf


gatk --java-options "-Xmx4G -XX:+UseParallelGC 
-XX:ParallelGCThreads=40" \
 CombineGVCFs -R $ref \
-V SRR5275203_pass_dedup_addrgp.g.vcf \
-V SRR5275204_pass_dedup_addrgp.g.vcf \
-V SRR5275205_pass_dedup_addrgp.g.vcf \
-V SRR5275206_pass_dedup_addrgp.g.vcf \
-V SRR5275209_pass_dedup_addrgp.g.vcf \
-V SRR5275210_pass_dedup_addrgp.g.vcf \
-V SRR5275211_pass_dedup_addrgp.g.vcf \
-V SRR5275212_pass_dedup_addrgp.g.vcf \
-V SRR5275213_pass_dedup_addrgp.g.vcf \
-V SRR5275214_pass_dedup_addrgp.g.vcf \
-V SRR5275215_pass_dedup_addrgp.g.vcf \
-V SRR5275216_pass_dedup_addrgp.g.vcf \
-V SRR5275217_pass_dedup_addrgp.g.vcf \
-V SRR5275218_pass_dedup_addrgp.g.vcf \
-V SRR5275219_pass_dedup_addrgp.g.vcf \
-V SRR5275220_pass_dedup_addrgp.g.vcf \
-V SRR5275231_pass_dedup_addrgp.g.vcf \
-V SRR5275232_pass_dedup_addrgp.g.vcf \
-V SRR5275233_pass_dedup_addrgp.g.vcf \
-V SRR5275234_pass_dedup_addrgp.g.vcf \
-V SRR5275235_pass_dedup_addrgp.g.vcf \
-V SRR5275236_pass_dedup_addrgp.g.vcf \
-V SRR5275237_pass_dedup_addrgp.g.vcf \
-V SRR5275238_pass_dedup_addrgp.g.vcf \
-V SRR5275239_pass_dedup_addrgp.g.vcf \
-V SRR5275240_pass_dedup_addrgp.g.vcf \
-V YI12-5F_dedup_addrgp.g.vcf \
-V YI19005-4_dedup_addrgp.g.vcf \
-V YI19011-7_dedup_addrgp.g.vcf \
-V YI19011-7F_dedup_addrgp.g.vcf \
-V YI19012-1_dedup_addrgp.g.vcf \
-V YI19012-1F_dedup_addrgp.g.vcf \
-V YI19012-3_dedup_addrgp.g.vcf \
-V YI19013-1_dedup_addrgp.g.vcf \
-V YI19013-1F_dedup_addrgp.g.vcf \
-V YI19013F_dedup_addrgp.g.vcf \
-V YI19025_dedup_addrgp.g.vcf \
-V YI19025T2_dedup_addrgp.g.vcf \
-V YI19025T3_dedup_addrgp.g.vcf \
-V YI19032_dedup_addrgp.g.vcf \
-V YI19032F2_dedup_addrgp.g.vcf \
-V YI19032F_dedup_addrgp.g.vcf \
-V YI19033F_dedup_addrgp.g.vcf \
-V YI19034_dedup_addrgp.g.vcf \
-V YI19035T_dedup_addrgp.g.vcf \
-V YI19039-3_dedup_addrgp.g.vcf \
-V YI19039-4_dedup_addrgp.g.vcf \
 -O $gvcfFile

gatk --java-options "-Xmx4G -XX:+UseParallelGC 
-XX:ParallelGCThreads=40" \
GenotypeGVCFs -R $ref -V total.g.vcf \
-O $vcfFile
