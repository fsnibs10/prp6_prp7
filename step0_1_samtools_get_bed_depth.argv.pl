use strict;

my %bed;
my $mm=0;
my $bamlist = $ARGV[0];
my $inputbed=$ARGV[1];
my $out=$ARGV[2];
open(IN,"<$inputbed") || die;
while (<IN>) {
	chomp;
	chop if(/\r$/);
	my @line = split(/\t/);
	$mm++;
	$bed{$mm} = $line[3];
	print "$mm\t$line[3]\n"; 
}
close IN;


my %all;
my %allsample;

my %bams;
open(IN,"<$bamlist") || die;
while(<IN>){
	chomp;
	chop if(/\r$/);
	my @line = split(/\t/);
	$bams{$line[0]} = $line[1];
}
close IN;

#my @bamfile = </data/b/jgs/copy_number_variation/Spombe/21.12_541strains_to_181clusters/KAT_reads_bam/*.bam>;
my @bamfile = sort keys %bams;


foreach my $ibam (@bamfile) {
	print "$ibam\t";
	#my ($sample) = $ibam =~ /KAT\_reads\_bam\/(\S+)\.KAT/;
	my $sample = $bams{$ibam};
	print "$sample\n";
	$allsample{$sample} = 1;
	open(IN,"<$inputbed") || die;
	while (<IN>) {
		chomp;
		chop if(/\r$/);
		my @line = split(/\t/);
		my $tcc= $line[1]+1;   # bed format start is 0-based
		my $tmpstr = $line[0].":".$tcc."-".$line[2];
#		print "-----$tmpstr\n";
		# my $total = `samtools depth -a -r $tmpstr $ibam | cut -f 3 | awk '{total = total + \$1} END {print total}' | tr -d "\n"`;
		# my $iave;
		# if($total != 0){
		# 	$iave = $total/1000;
		# }else{
		# 	$iave = 0;
		# }
		
		# get median value for each window
		my $imedian = `samtools depth -a -r $tmpstr $ibam | cut -f 3 | st --median | tr -d "\n"`;

		

		$all{$line[3]}{$sample} = $imedian;
#print "$line[3]\t$sample\t$iave\n";


	}
	close IN;
}


open(OUT,">$out") || die;
foreach my $isample (sort keys %allsample) {
	print OUT "\t$isample";
}
print OUT "\n";
foreach my $imm (sort {$a <=> $b} keys %bed ) {
	print OUT "$bed{$imm}";
	foreach my $isample (sort keys %allsample) {
		print OUT "\t$all{$bed{$imm}}{$isample}";
	}
	print OUT "\n";
}



close OUT;


