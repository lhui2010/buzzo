#!/usr/bin/env python
# coding: utf-8
import shlex, subprocess
import re
from os.path import basename
job_id_array=[]
with open ("blast_command.sh") as file:
    for line in file:
        if(not re.findall('^blastp', line)):
            continue
        ele=line.split();
        evalue=ele[4]
        query=ele[6]
        db=ele[8]
        out=ele[10]
        bashCommand = "split_fastav3.pl " + query + " 100"
        process = subprocess.Popen(shlex.split(bashCommand), stdout=subprocess.PIPE)
        output, error = process.communicate()
        for fasta in output.decode("ascii").split():
            #print (str(fasta))
            dbbase=basename(db)
            bln=fasta + "." + dbbase +".bln"
            bsname=basename(fasta)
#TODO add cat bln >>out
            bashCommand = "qsub -V -b y -N blast" + bsname + ' -o /dev/null -e /dev/null -cwd "blastp -outfmt 6 -evalue '+ evalue + " -query " + fasta + " -db " + db + " -out " + bln +'"'
            qsub_process = subprocess.Popen(shlex.split(bashCommand), stdout=subprocess.PIPE)
            qsub_output, qsub_error = qsub_process.communicate()
            qsub_id=qsub_output.split()[2]
            job_id_array.append(qsub_id.decode("ascii"))

with open ("job_id", 'w') as f:
    for id in job_id_array:
        f.write(id + "\n")
#while job_id_array >0
#for loop
#qstat -j job
#if Job do not exists
#rm job_id_arrary[job]
#for loop end
#sleep 1m

