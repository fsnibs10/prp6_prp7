# conda activate nanocomp

#reads1="raw_reads/Y37X2R_1_LT_prp7ts_.fastq.gz"
#reads2="raw_reads/Y37X2R_2_LT_ptp7WT_.fastq.gz"
#sample1="prp7ts"
#sample2="prp7wt"

reads=(
raw_reads/T22506180516-3514.fastq.gz
raw_reads/T22506180517-3557.fastq.gz
raw_reads/T22511102034_251106-lig4D-veg-lib.raw.fastq.gz
raw_reads/34RP6R_1_prp6_1_ts_cells.fastq.gz
raw_reads/Z4CRNT_1_prp6_1_wt_cells.fastq.gz
raw_reads/Y37X2R_1_LT_prp7ts_.fastq.gz
raw_reads/Y37X2R_2_LT_ptp7WT_.fastq.gz
raw_reads/CV6HNK_1_LT_wLid3_.fastq.gz
raw_reads/H6MYBD_1_LT_wo_lid3_.fastq.gz
)

samplename=(
Du3514
Du3557
DuLig4D
prp6ts
prp6wt
prp7ts
prp7wt
withLid3
withoutLid3
)

#NanoComp --fastq $reads1 $reads2 --names $sample1 $sample2 -o prp7.nanocomp

# 检查两个数组长度是否一致
if [ "${#reads[@]}" -ne "${#samplename[@]}" ]; then
  echo "Error: reads 和 samples 数量不一致！" >&2
  exit 1
fi


NanoComp --fastq "${reads[@]}" --names "${samplename[@]}" -o all.nanocomp

echo "all done"
