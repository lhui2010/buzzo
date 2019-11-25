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


#Need ~15min
#samtools faidx $ref

cd /ds3200_1/users_root/yitingshuang/lh/fragaria/buzzo/gatk/input
for mapFile in *_dedup.bam
do
#Call SNP
    infile=${mapFile}
    outfile=${mapFile%.bam}_addrgp.bam
    java -jar ~/lh/bin/picard.jar AddOrReplaceReadGroups I=$infile  O=$outfile  RGID=group1 RGLB=lib1 RGPL=illumina RGPU=unit1 RGSM=${mapFile%.bam} &
done
wait

