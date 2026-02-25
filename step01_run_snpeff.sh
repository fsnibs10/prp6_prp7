snpEff_root="/home/suofang/Software/snpEff_v4_3t/snpEff"

for i in `find *.vcf`;
do
    echo $i
    # Run snpEff
    java -jar $snpEff_root/snpEff.jar ann -no-utr -no-downstream -no-upstream -no-intergenic SpombeLeupoldv250825 $i > $i.snpeff.vcf


done

echo "done!"


