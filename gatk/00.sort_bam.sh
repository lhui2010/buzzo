
cd input
for i in *.sam; do bsub512 -n 2 "samtools sort ${i} -@ 2 -n -m 4G -T ${i%.*} -o ${i%.*}.bam" ; done
