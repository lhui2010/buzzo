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
#tempory specify
#ROOT=/lustre/home/liuhui/project/buzzo/OrthoFinder/running/maize_v1.1
#DIR=/lustre/home/liuhui/project/buzzo/OrthoFinder/running/maize_v1.1/Results_Sep04/WorkingDirectory


mkdir species_tree && cd species_tree
SPECIES_DIR=$PWD

echo $DIR/SingleCopyOrthogroups.txt
cat $ROOT/*.fa >total.pep
cat $ROOT/cds/*.fa >total.cds
perl $SCRIPT_DIR/selectIterm.pl  $DIR/SingleCopyOrthogroups.txt $DIR/Orthogroups.txt >SingleCopyOrthogroups_with_gene.txt

#will create a dir with group ID, and generate fasta file of corresponding gene family in that dir
#parameter: group_file  pep_fasta_file  suffix_of_fasta
python $SCRIPT_DIR/group2fasta.py $SPECIES_DIR/SingleCopyOrthogroups_with_gene.txt total.pep pep
python $SCRIPT_DIR/group2fasta.py $SPECIES_DIR/SingleCopyOrthogroups_with_gene.txt total.cds cds


for g in OG*
    do
        #echo "cd $SPECIES_DIR/$g && t_coffee ${g}.pep -method mafftgins_msa,muscle_msa,kalign_msa,t_coffee_msa > ${g}.pep.aln &&  pal2nal.pl ${g}.pep.aln ${g}.cds   >${g}.paml_aln "
        #qsub  -V -b y -N $g -cwd "cd $SPECIES_DIR/$g && t_coffee ${g}.pep -method mafftgins_msa,muscle_msa,kalign_msa,t_coffee_msa > ${g}.pep.aln &&  pal2nal.pl ${g}.pep.aln ${g}.cds   >${g}.paml_aln "
        qsub  -V -b y -N $g -cwd "cd $SPECIES_DIR/$g && t_coffee ${g}.pep -mode fmcoffee > ${g}.pep.aln &&  pal2nal.pl ${g}.pep.aln ${g}.cds   >${g}.paml_aln "
        done
        
#        && clustalw2fasta ${g}.paml_aln >${g}.paml_aln.fa

#        fa2phy.pl ${g}.paml_aln.fa >${g}.paml_aln.phy #OK
#        FastTreeMP <${g}.paml_aln.fa >${g}.paml_tree #wrong format, use phylip
#        sed -ie 's/)[0-9].[0-9]\+:/):/g' ${g}.paml_tree #remove bootstrap value


##$ -pe smp 56
