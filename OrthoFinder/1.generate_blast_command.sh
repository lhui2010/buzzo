#!/bin/bash
#
#$ -cwd
#$ -V
#$ -S /bin/bash
#$ -l h=cn01
#$ -l h=cn01
#$ -N ortho
#

orthofinder -f fasta -op -t 56 -a 56 -M msa  >blast_command.sh
##$ -pe smp 56
