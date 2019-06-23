#!/bin/bash
#
#$ -cwd
#$ -V
#$ -S /bin/bash
#$ -N ortho
#

set -euxo pipefail

#ROOT=$PWD/fasta
#DIR=`ls -d $PWD/fasta/Results_*/WorkingDirectory`
BASE_DIR=$PWD
SCRIPT_DIR=$BASE_DIR

#TODO change maize_v1.1 to default dir
ROOT=/lustre/home/liuhui/project/buzzo/OrthoFinder/running/maize_v1.1
DIR=/lustre/home/liuhui/project/buzzo/OrthoFinder/running/maize_v1.1/Results_Sep04/WorkingDirectory


cd ${ROOT}
mkdir -p Alignments && cd Alignments
WORKDIR=$PWD

#TODO remove comments in release version
#cat $ROOT/*.fa >total.pep
#cat $ROOT/cds/*.fa >total.cds


#TODO remove comments in release version
#will create a dir with group ID, and generate fasta file of corresponding gene family in that dir
#parameter: group_file  pep_fasta_file  suffix_of_fasta
#python $SCRIPT_DIR/group2fasta.py $DIR/Orthogroups.csv total.pep pep
#python $SCRIPT_DIR/group2fasta.py $DIR/Orthogroups.csv total.cds cds

cut -f1 $DIR/Orthogroups.csv |sort -r |sed 's/ *$//' >group_list

for g in `cat group_list`
#for g in OG0029000
    do
##        echo "cd $WORKDIR/$g && t_coffee ${g}.pep -method mafftgins_msa,muscle_msa,kalign_msa,t_coffee_msa > ${g}.pep.aln &&  pal2nal.pl ${g}.pep.aln ${g}.cds   >${g}.paml_aln "
        cd $WORKDIR/$g
        echo "fileToExe = \"/lustre/home/liuhui/bin/anaconda3/lib/hyphy/TemplateBatchFiles/SelectionAnalyses/aBSREL.bf\";


inputRedirect = {};
inputRedirect[\"01\"]=\"Universal\";
inputRedirect[\"02\"]=\"$WORKDIR/$g/${g}.fna\";
inputRedirect[\"03\"]=\"$WORKDIR/$g/${g}.nwk\";
inputRedirect[\"04\"]=\"All\";

ExecuteAFile( fileToExe, inputRedirect);
" >${g}.bs

#mafft is too slow
#        qsub  -V -b y -N $g -cwd "cd $WORKDIR/$g && t_coffee ${g}.pep -method mafftgins_msa,muscle_msa,kalign_msa,t_coffee_msa > ${g}.pep.aln &&  pal2nal.pl ${g}.pep.aln ${g}.cds   >${g}.paml_aln && trimal -in ${g}.paml_aln -out ${g}.fna -fasta && HYPHYMP ${g}.bs > ${g}.hyphy_log"
#        qsub  -V -b y -N $g -cwd "cd $WORKDIR/$g && t_coffee ${g}.pep -mode fmcoffee > ${g}.pep.aln &&  pal2nal.pl ${g}.pep.aln ${g}.cds   >${g}.paml_aln && trimal -in ${g}.paml_aln -out ${g}.fna -fasta && HYPHYMP ${g}.bs > ${g}.hyphy_log"
        qsub -pe smp 5 -V -b y -N $g -cwd "cd $WORKDIR/$g && t_coffee ${g}.pep -mode fmcoffee > ${g}.aln.out && cp ${g}.aln ${g}.pep.aln &&  pal2nal.pl ${g}.pep.aln ${g}.cds   >${g}.paml_aln && trimal -in ${g}.paml_aln -out ${g}.fna -fasta && trimal -in ${g}.pep.aln -out ${g}.pep.fna -fasta && fasttree ${g}.pep.fna >${g}.nwk && touch -a ${g}.fna.ABSREL.json && mv ${g}.fna.ABSREL.json ${g}.fna.ABSREL.json.bak && HYPHYMP ${g}.bs > ${g}.hyphy_log"

        sleep 1s

        cd $WORKDIR
        done
        
#        && clustalw2fasta ${g}.paml_aln >${g}.paml_aln.fa

#        fa2phy.pl ${g}.paml_aln.fa >${g}.paml_aln.phy #OK
#        FastTreeMP <${g}.paml_aln.fa >${g}.paml_tree #wrong format, use phylip
#        sed -ie 's/)[0-9].[0-9]\+:/):/g' ${g}.paml_tree #remove bootstrap value


##$ -pe smp 56
