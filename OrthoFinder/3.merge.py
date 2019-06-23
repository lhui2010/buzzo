#!/usr/bin/env python

import shlex, subprocess
from os.path import basename
import re

#check if complete
with open ("blast_command.sh") as file:
    for line in file:
        if(not re.findall('^blastp', line)):
            continue
        ele=line.split();
        evalue=ele[4]
        query=ele[6]
        db=ele[8]
#return the target output blast file used by OrthoFinder, and the target for merging blasts
        out=ele[10]
        bashCommand = "split_fastav3.pl " + query + " 100"
#return the list of splited files
        process = subprocess.Popen(shlex.split(bashCommand), stdout=subprocess.PIPE)
        output, error = process.communicate()
        with open (out, 'w') as outfile:
            for fasta in output.decode("ascii").split():
                dbbase=basename(db)
                bln=fasta + "." + dbbase +".bln"
                with open(bln) as infile:
                    outfile.write(infile.read())                
