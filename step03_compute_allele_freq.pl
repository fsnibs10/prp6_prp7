use strict;


open(IN,"<prp7-prp6-lid3.E30.joint.clair3.yml.vcf.snpeff.vcf") || die;
open(OUT,">prp7-prp6-lid3.E30.joint.clair3.yml.vcf.snpeff.vcf.xls")  || die;
while (<IN>){
	chomp;
	chop if(/\r$/);
	next if(/^\#\#/);
	my @line = split(/\t/);
	if($line[0] eq "#CHROM"){
		print OUT "$line[0]\t$line[1]\t$line[2]\t$line[3]\t$line[4]";
		my $samples = join("\t",@line[9..$#line]);
		print OUT "\t$samples\n";
		print "$samples\n";
	}else{
		next if($line[4] =~ /\,/);
		print OUT "$line[0]\t$line[1]\t$line[2]\t$line[3]\t$line[4]";
		for(my $n=9; $n<=$#line; $n++){
			my @tmp = split(/:/,$line[$n]);
			my $gt = $tmp[0];
			my $dp = $tmp[1];
			my $ad = $tmp[2];
			my @allAD = split(/\,/,$ad);
			my $AAF;
			if($allAD[0] + $allAD[1] == 0){
				$AAF = "NA";
			}else{
				$AAF = sprintf("%.3f",$allAD[1]/($allAD[0]+$allAD[1]));
			}

			my $info = "$gt:$dp:$ad:$AAF";
			print OUT "\t$info";
		}
		print OUT "\n";
	}
	
	
}
close IN;
close OUT;

