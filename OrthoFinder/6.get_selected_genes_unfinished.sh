#!/bin/bash
#
#$ -cwd
#$ -j y
#$ -V
#$ -S /bin/bash
#$ -N cat
#

cd maize_v1.1

for j in `cat json_full`; do i=Alignments/OG${j}/OG${j}.hyphy_log;  perl -e 'print $ARGV[0], "\t"; my $mark=0; while(<>){if(/^### Adaptive branch site random effects likelihood test/){$mark = 1;} if($mark){print;}}' $i >>aBSREL.txt; done
echo "A188"
grep "^* A188" aBSREL.txt >aBSREL.txt.A188
wc -l aBSREL.txt.A188
echo "Mo17"
grep "^* PWZ" aBSREL.txt >aBSREL.txt.Mo17
wc -l aBSREL.txt.Mo17
echo "B73"
grep "^* Zm00001" aBSREL.txt >aBSREL.txt.B73
wc -l aBSREL.txt.B73
echo "W22"
grep "^* Zm00004" aBSREL.txt >aBSREL.txt.W22
wc -l aBSREL.txt.W22
echo "PH207"
grep "^* Zm00008" aBSREL.txt >aBSREL.txt.PH207
wc -l aBSREL.txt.PH207
echo "Sorghum"
grep "^* sorghum" aBSREL.txt >aBSREL.txt.Sorghum
wc -l aBSREL.txt.Sorghum


