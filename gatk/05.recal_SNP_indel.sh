#!/bin/bash
#
#BSUB -J hybrid_job_name      # job name
#BSUB -n 32                   # number of tasks in job
#BSUB -q Q104C512G_X4_1              # queue
#BSUB -e errors.%J     # error file name in which %J is replaced by the job ID
#BSUB -o output.%J     # output file name in which %J is replaced by the job ID

#BQSR ref  https://software.broadinstitute.org/gatk/documentation/article.php?id=44
#VariantRecalibrator ref  https://software.broadinstitute.org/gatk/documentation/tooldocs/3.8-0/org_broadinstitute_gatk_tools_walkers_variantrecalibration_VariantRecalibrator.php
#VQSR ref  https://software.broadinstitute.org/gatk/documentation/article?id=39
##BQSR and VQSR were not performed here as this is a non-human species and have no high confident set for training
#https://gatkforums.broadinstitute.org/gatk/discussion/1706/best-recommendation-for-base-recalibration-on-non-human-data

ref=/ds3200_1/users_root/yitingshuang/lh/fragaria/buzzo/gatk/ref/F_vesca_H4_V4.1.fasta

cd /ds3200_1/users_root/yitingshuang/lh/fragaria/buzzo/gatk/input
vcfFile=total.vcf
#Select SNP  and Indel
gatk SelectVariants -R $REF.fa -V ${vcfFile} -select-type SNP -O ${vcfFile}.raw_snp.vcf
gatk selectvariants -r $ref.fa -v ${vcfFile} -select-type indel -O ${vcfFile}.raw_indel.vcf

#Filter SNPs 
#Following https://software.broadinstitute.org/gatk/documentation/article?id=11097
gatk VariantFiltration -R $REF.fa -V ${vcfFile}.raw_snp.vcf --filterExpression 'QD < 2.0 || FS > 60.0 || MQ < 40.0 || MQRankSum < -12.5 || ReadPosRankSum < -8.0 || SOR > 3.0' --filterName "basic_snp_filter" -o ${vcfFile}.filter_snp.vcf

#Filter INdel
gatk VariantFiltration -R $REF.fa -V ${vcfFile}.raw_indel.vcf --filterExpression 'QD < 2.0 || FS > 200.0 || ReadPosRankSum < -20.0 || SOR > 10.0 || InbreedingCoeff < -0.8' --filterName "basic_indel_filter" -o ${vcfFile}.filter_indel.vcf
