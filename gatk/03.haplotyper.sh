#!/bin/bash
#BSUB -J hybrid_job_name      # job name
#BSUB -n 32                   # number of tasks in job
#BSUB -q Q104C512G_X4_1              # queue
#BSUB -e errors.%J     # error file name in which %J is replaced by the job ID
#BSUB -o output.%J     # output file name in which %J is replaced by the job ID

#BQSR

set -euxo pipefail

ref=/ds3200_1/users_root/yitingshuang/lh/fragaria/buzzo/gatk/ref/F_vesca_H4_V4.1.fasta
GATK_HOME=/ds3200_1/users_root/yitingshuang/lh/bin/gatk-4.1.4.0

#samtools faidx $ref
cd /ds3200_1/users_root/yitingshuang/lh/fragaria/buzzo/gatk/input
for mapFile in *_dedup_addrgp.bam
do
#Need circa 12 hours
#Call SNP
    samtools index ${mapFile}
    infile=${mapFile}
    outfile=${mapFile%.bam}.g.vcf
    gatk --java-options "-Xmx4G -Djava.library.path=$GATK_HOME/libs \
    -XX:+UseParallelGC -XX:ParallelGCThreads=10" HaplotypeCaller \
    -R ${ref} -I $infile \
    --native-pair-hmm-threads 8 \
    -O $outfile -ERC GVCF -stand-call-conf 10  &
done
wait


