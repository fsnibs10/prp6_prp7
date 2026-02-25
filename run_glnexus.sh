# I have a try with gatk_unfiltered, it also worked.
#~/software/glnexus_cli --config gatk_unfiltered --list gvcf.list | bcftools view -Oz -o test_lid3.joint_gatk_unfiltered.vcf.gz

# github gives the yml
~/software/glnexus_cli --config clair3.yml --list gvcf.list | bcftools view -Oz -o prp7-prp6-lid3.E30.joint.clair3.yml.vcf.gz

