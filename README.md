# Variant calling for long sequencing reads

## Reads evaluation with NanoComp
```
sh run_nanocomp.sh
```
## Calculate the median depth of essential genes on chromosome 1
```
sh run_minimap2.sh # for total reads mapping

# get the depth of each genes from bed files
perl step0_1_samtools_get_bed_depth.argv.pl bam_full.list Leupold_chr1_E_gene.bed bamFull.depth  
```

## Downsamping reads
```
sh count_total_bases.sh
sh seqtk_subreads.sh
```
## Mapping with minimap2
```
sh run_minimap2.sh
```
## Variant calling with Clair3
```
sh run_clair3_2_batchly_sample_model_default_options.sh
```

## Merge gvcf files with Glnexus
```
sh run_glnexus.sh
```

## Varaint annotation with SnpEff
```
# Input file is the merged vcf
sh step01_run_snpeff.sh  
perl step02_Step5_extract_snpEff_from_vcf.pl
perl step03_compute_allele_freq.pl  
perl step04_combine_snpeff_and_genotype.pl 
```
