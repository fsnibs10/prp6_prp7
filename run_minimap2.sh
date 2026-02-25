while read fq assembly sample
do
	echo $sample
	#minimap2 -ax map-ont $assembly $fq > $sample.sam
	minimap2 -ax lr:hq $assembly $fq > $sample.sam
	samtools sort -@ 8 -o $sample.bam $sample.sam
	samtools index $sample.bam
	rm $sample.sam

done < config.list

echo "all done"
