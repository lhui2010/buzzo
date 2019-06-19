package var;

use strict;
use warnings;

our %GENOME_HASH=(
    "maize" => "/lustre/local/database/GENOME/zea_mays_agp_v4/Zea_mays.AGPv4.dna_sm.toplevel.fa",
    "tomato" => "/lustre/local/database/GENOME/solanum_lycopersicum/Solanum_lycopersicum.SL2.50.dna_sm.toplevel.fa",
    "wtomato" => "/lustre/local/database/GENOME/solanum_pennellii/Spenn.fasta",
    "w3tomato" => "/lustre/local/database/GENOME/solanum_pennellii_Ion/Spenn_Ion.fa",
    "arabidopsis" =>"/lustre/local/database/GENOME/arabidopsis_thaliana/Arabidopsis_thaliana.TAIR10.dna_sm.toplevel.fa",
    "cucumber" => "/lustre/local/database/GENOME/cucumber/cucumber_ChineseLong_v2_genome.fa",
    "cuscuta" => "/lustre/local/database/GENOME/cuscuta_australis/Cuscuta.genome.v1.1.fasta",
    "niatt" => "/lustre/local/database/GENOME/nicotiana_attenuata/niatt_genome.fa",
    "A188" => "/lustre/local/database/GENOME/A188/A188.genome.fa",
    "niben" => "/lustre/local/database/GENOME/Nicotiana_benthamiana/v044/Niben_genome.fa",
    );
our %GTF_HASH=(
    "maize" => "/lustre/local/database/GENOME/zea_mays_agp_v4/Zea_mays.AGPv4.32.gff3",
    "tomato" => "/lustre/local/database/GENOME/solanum_lycopersicum/Solanum_lycopersicum.SL2.50.32.gff3",
    "wtomato" => "/lustre/local/database/GENOME/solanum_pennellii/spenn_v2.0_gene_models_annot.gff",
    "arabidopsis" => "/lustre/local/database/GENOME/arabidopsis_thaliana/Arabidopsis_thaliana.TAIR10.32.gff3",
    "cucumber" => "/lustre/local/database/GENOME/cucumber/cucumber_ChineseLong_v2.gff3",
    "cuscuta" => "/lustre/local/database/GENOME/cuscuta_australis/Cuscuta.v1.1.gff3",
    "niatt" => "/lustre/local/database/GENOME/nicotiana_attenuata/ref_NIATTr2_top_level.gff3",
    "A188" => "/lustre/local/database/GENOME/A188/v1.1_chr/A188_chr.total.gff",
    "niben" => "/lustre/local/database/GENOME/Nicotiana_benthamiana/v044/Niben.genome.v0.4.4.gene_models.annotated.gff",
    );
    #"A188" => "/lustre/local/database/GENOME/A188/A188.gff",

our %FUNC_HASH=(
    "maize" => "/lustre/local/database/GENOME/zea_mays_agp_v4/Zea_mays.AGPv4.function.tsv",
    "tomato" => "/lustre/local/database/GENOME/solanum_lycopersicum/Solanum_lycopersicum.SL2.50.function.tsv",
    "wtomato" => "/lustre/local/database/GENOME/solanum_pennellii/Spenn_v2.0.function.tsv",
    "arabidopsis" => "/lustre/local/database/GENOME/arabidopsis_thaliana/Arabidopsis_thaliana.TAIR10.function.tsv",
    "cucumber" => "/lustre/local/database/GENOME/cucumber/cucumber_ChineseLong_v2.function.tsv",
    "cuscuta" => "/lustre/local/database/GENOME/cuscuta_australis/Cuscuta_function_table.tsv",
    "niatt" => "/lustre/local/database/GENOME/nicotiana_attenuata/niatt_protein.function.tsv",
    "A188" => "/lustre/local/database/GENOME/A188/A188.function.tsv",
    "niben" => "/lustre/local/database/GO/Niben.genome.v0.4.4.GO",
    );
1;
