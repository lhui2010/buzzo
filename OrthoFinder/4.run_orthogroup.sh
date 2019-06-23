#!/bin/bash
#
#$ -cwd
#$ -V
#$ -S /bin/bash
#$ -N ortho
#$ -l h=fat01
#

DIR=`ls -d $PWD/fasta/Results_*/WorkingDirectory`

#orthofinder -f fasta -op -t 56 -a 56 -M msa  >blast_command.sh
orthofinder -b ${DIR}  -t 160
##$ -pe smp 56
