use strict;
my %genotype;
open(IN,"<prp7-prp6-lid3.E30.joint.clair3.yml.vcf.snpeff.vcf.xls") || die;
my $title = <IN>;
chomp $title;
chop $title if($title =~ /\r$/);
my @title = split(/\t/,$title);
my $sample = "$title[5]\t$title[6]\t$title[7]\t$title[8]\t$title[9]\t$title[10]\t$title[11]\t$title[12]\t$title[13]";
while (<IN>){
	chomp;
	chop if(/\r$/);
	my @line = split(/\t/);
	$genotype{$line[0].$line[1].$line[3].$line[4]} = "$line[5]\t$line[6]\t$line[7]\t$line[8]\t$line[9]\t$line[10]\t$line[11]\t$line[12]\t$line[13]";

}
close IN;

open(IN,"<all_variant_snpEff.txt") || die;
my $title2= <IN>;
open(OUT,">all_variant_snpEff.txt.add_genotype.txt") || die;
print OUT "$sample\t$title2";
while(<IN>){
	chomp;
	chop if(/\r$/);
	my @line = split(/\t/);
	if($line[2] !~ /\,/ && $line[3] !~ /\,/){
		my $id = $line[0].$line[1].$line[2].$line[3];
		if(exists($genotype{$id})){
			print OUT "$genotype{$id}\t$_\n";
		}else{
			print "not found:\t$_\n";
		}
	}	
}
close IN;
close OUT;

