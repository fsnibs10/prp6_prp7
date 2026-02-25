while read fq reads sample
do 
	echo $sample
	seqtk sample -s 11 $fq $reads | gzip > $sample.fq.gz

done < sample.list

echo "all done"


