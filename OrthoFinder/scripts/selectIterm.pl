#!/usr/bin/perl -w


if(@ARGV <2)
{
        print "Usage: \n\t$0 list input >output\n";
        exit;
}

open LIST, $ARGV[0] or $name{$ARGV[0]}=1;
while(<LIST>)
{
        chomp;
       @e=split;
       $name{$e[0]} = $_;


}

shift @ARGV;
while(<>)
{
        chomp;
        my $t = (split /\s+/, $_)[0];
        $t=~s/://;

        if(exists $name{$t})
        {
        print $_,"\n";
        }
}

