#!/usr/bin/env perl
use strict;
use warnings;
use Cwd;

#DB table 
use var;

my %GENOME_HASH =  %var::GENOME_HASH;
my %GTF_HASH = %var::GTF_HASH;
my %FUNC_HASH= %var::FUNC_HASH;


#Running Config
my $threads=8;



my $dir = getcwd;
my @list = `ls -d */`;

#my @cmd;

for my $user (@list)
{
    $user=~s/\/\n//;
    print $user;<STDIN>;
    chdir ($dir);

    my @sp_name=`ls -d $user/input*/`;

	for my $sp_name(@sp_name)
	{
    $sp_name=~s/.*input_//;
    $sp_name=~s/\/\n//;

    chdir ("$dir/$user/result");
    my $GM=$GENOME_HASH{$sp_name};
    my $GTF=$GTF_HASH{$sp_name};
    my $FUNC=$FUNC_HASH{$sp_name};

    my $cmd="qsub -V -b y -N output -cwd \"add_func.pl $FUNC $sp_name.gene_DE.xls >$sp_name.gene_DE.func.xls\"";

    system ($cmd);
	}
}


