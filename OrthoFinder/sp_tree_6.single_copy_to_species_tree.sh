#!/bin/bash
#
#$ -cwd
#$ -V
#$ -S /bin/bash
#$ -N ortho
#

set -euxo pipefail

ROOT=$PWD/fasta
DIR=`ls -d $PWD/fasta/Results_*/WorkingDirectory`
BASE_DIR=$PWD
SCRIPT_DIR=$BASE_DIR

#orthofinder -f fasta -op -t 56 -a 56 -M msa  >blast_command.sh
#temp specify
#ROOT=/lustre/home/liuhui/project/buzzo/OrthoFinder/running/maize_v1.1
#DIR=/lustre/home/liuhui/project/buzzo/OrthoFinder/running/maize_v1.1/Results_Sep04/WorkingDirectory


#mkdir species_tree && 
#cd SPECIES_DIR=$PWD
SPECIES_DIR=$BASE_DIR/species_tree
mkdir -p tree_dir && cd tree_dir
TREE_DIR=$BASE_DIR/tree_dir


cat $SPECIES_DIR/*/*paml_aln |grep -v CLUSTAL |sed 's/A188.*\s/A188    /; s/PW.*\s/Mo17    /; s/Zm00001d.*\s/B73     /; s/Zm00004.*\s/W22     /; s/Zm00008.*\s/PH207   /; s/sorghum.*\s/Sorghum /; s/ZMex.*\s/Teo     /' >$TREE_DIR/total.aln

sed -i '1iCLUSTAL W multiple sequence alignment' $TREE_DIR/total.aln

perl $SCRIPT_DIR/clustal2fasta.py $TREE_DIR/total.aln

#qsub -V -b y -N fasttree -cwd  "fasttree <$TREE_DIR/total.aln.fa >$TREE_DIR/species.nwk"
qsub -V -b y -N raxml -cwd -l h=fat01 "raxmlHPC-PTHREADS -f a -x 32431 -p 43213 -# 100 -m GTRGAMMA  -T 160 -s total.aln.fa -n maize_sp"
