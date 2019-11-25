#!/usr/bin/env perl
use warnings;
use Cwd;
use var;

my %GENOME_HASH =  %var::GENOME_HASH;
my %GTF_HASH = %var::GTF_HASH;



####################################################################
#How To Use?
#
#require input_${species_name} fold present in subfolder of user dir.
#input_${species_name} contains all clean reads that would be used for analysis.
#name.txt present in user dir: specifing relaships between sample ID and analysis ID(with rep)
#usage: perl batch_run.pl
#it will automatically start hisat-samtools-stringtie pipeline
#it will also ask you to confirm before submit to cluster
#
####################################################################

#Running Config
my $threads=8;



my $dir = getcwd;
my @list = `ls -d */`;

for my $user (@list)
#for my $user (qw/saif/)
{
    my @cmd;
    $user=~s/\/\n//;
    print $user;<STDIN>;
    chdir ($dir);


    my @sp_name=`ls -d $user/input*/`;

	for my $sp_name(@sp_name)
	{
    $sp_name=~s/.*input_//;
    $sp_name=~s/\/\n//;

    my (%left, %right);
    #print $sp_name;exit;
    my $GM=$GENOME_HASH{$sp_name};
    my $GTF=$GTF_HASH{$sp_name};

    my $PE_PATH="$dir/$user/input_$sp_name";
    #print $PE_PATH;exit;
    chdir ($PE_PATH) or die "cannot change: $!\n";

    open IN, "../name.txt" or die;
    while(<IN>)
    {
        my ($sampleID, $newID) = split;
#remove illegle character
		$newID=~s/\(/_/g;
		$newID=~s/\)/_/g;
		$newID=~s/[^\x00-\x7F]/_/g;

        my $tmp=$sampleID."_";
        $newID.=".tuxedo";
        $left{$newID} = `ls $tmp*_1.clean.fq.gz`;
        $right{$newID} = `ls  $tmp*_2.clean.fq.gz`;
        chomp($left{$newID});
        chomp($right{$newID});
		if ($left{$newID} eq "" or $right{$newID} eq "")
		{
			delete $left{$newID};
			delete $right{$newID};
			next;
		}
#When on SGE system
        #my $print ="cd $PE_PATH && qsub  -cwd -j n -b y -V -N $newID -pe smp $threads  \"hisat2 --mp 3,1 -p $threads -x $GM -1 $PE_PATH/$left{$newID} -2 $PE_PATH/$right{$newID} -S $newID.sam   && samtools sort -@ $threads -o $newID.bam $newID.sam && stringtie -e -b $newID-st-abun-out -p $threads -G $GTF -o $newID.with_novel.gtf -A $newID.exp_table $newID.bam \"";
#When on LSF system
        my $print ="cd $PE_PATH && bsub  -J $newID -n $threads -o output.%J  \"hisat2 --mp 3,1 -p $threads -x $GM -1 $PE_PATH/$left{$newID} -2 $PE_PATH/$right{$newID} -S $newID.sam   && samtools sort -@ $threads -o $newID.bam $newID.sam && stringtie -e -b $newID-st-abun-out -p $threads -G $GTF -o $newID.with_novel.gtf -A $newID.exp_table $newID.bam \"";
        print $print, "\n";
        push @cmd, $print;
    }
    close IN;
	}
#For every user ask
    print "\n\n\nReady to submit? Press Y to continue: ";
    chomp (my $input=<STDIN>);
    next unless (lc($input) eq "y");
    open OUT, ">>01.align.log" or die;
    print OUT $_,"\n" for @cmd;
    close OUT;
    system($_) for @cmd;

}

