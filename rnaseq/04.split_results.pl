#!/usr/bin/env perl
use strict;
use warnings;
use Cwd;

#DB table 

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

    open IN, "$sp_name.gene_DE.func.xls" or die;
    my $header = <IN>;
    my %buffer;
    my $count;
    while(<IN>)
    {
        my @e=split;
#Column of Sample 1 and Sample 2
        my $key="$e[7].vs.$e[8]";
#        print $key, "\n" if ($count++<1);
        $buffer{$key} = $header if (!exists $buffer{$key});
        $buffer{$key}.=$_;
    }
    close IN;
    for my $k (keys %buffer)
    {
        open OUT, ">$sp_name.gene_DE.func.$k.xls" or die;
        print OUT $buffer{$k};
        close OUT;
    }
    undef %buffer;
	}
}

