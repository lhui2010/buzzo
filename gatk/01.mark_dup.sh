
cd input
for mapFile in *.bam; do bsub -q Q104C512G_X4_1  -o output.%J -e error.%J -n 2 "samtools fixmate -m -@ 4 ${mapFile} ${mapFile}.fixmate.bam && \
    samtools sort -@ 4 -m 6G -o ${mapFile}.fixmate.sorted.bam ${mapFile}.fixmate.bam && \
    samtools markdup -s -@ 4 ${mapFile}.fixmate.sorted.bam ${mapFile%.bam}_dedup.bam && \
    samtools index -@ 4 ${mapFile%.bam}_dedup.bam" ; done

exit

#BQSR

cd input
for mapFile in *_dedup.bam
do
    for i in `seq -f ‘%04g’ 0 39`
    do
        outfile=${mapFile%.bam}_dedup_recal_data_$i.table
        gatk --java-options “-Xmx4G -XX:+UseParallelGC \
        -XX:ParallelGCThreads=4” BaseRecalibrator \
        -L $i-scattered.interval_list -R $ref \
        -I ${mapFile%.bam}_dedup.bam $knownSiteArg -O $outfile &
    done
    wait
    for i in `seq -f ‘%04g’ 0 39`
    do
        bqfile=${mapFile%.bam}_dedup_recal_data_$i.table
        output=${mapFile%.bam}_dedup_recal_$i.bam
        gatk --java-options “-Xmx4G -Xmx4G -XX:+UseParallelGC \
        -XX:ParallelGCThreads=4” ApplyBQSR -R $ref \
        -I ${mapFile%.bam}_dedup.bam \
        -L $i-scattered.interval_list -bqsr $bqfile \
        --static-quantized-quals 10 --static-quantized-quals 20 \
        --static-quantized-quals 30 -O $output &
    done
wait
done
