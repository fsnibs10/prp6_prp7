while read bam ref sample
do

echo "----------------$sample----------------"
INPUT_DIR="/data/a/suofang/MyWork/20251215_gould_lab_prp7/input"
OUTPUT_DIR="/data/a/suofang/MyWork/20251215_gould_lab_prp7/${sample}"
mkdir -p $OUTPUT_DIR
THREADS="8"
#MODEL_NAME="r1041_e82_400bps_sup_v430_bacteria_finetuned"
MODEL_NAME="r1041_e82_400bps_sup_v500"

docker run --rm --gpus all \
  -u $(id -u):$(id -g) \
  -v ${INPUT_DIR}:/input \
  -v ${OUTPUT_DIR}:/output \
  hkubal/clair3-gpu:latest \
  /opt/bin/run_clair3.sh \
    --bam_fn=/input/$bam \
    --ref_fn=/input/$ref \
    --threads=${THREADS} \
    --platform="ont" \
    --sample_name=${sample} \
    --model_path="/opt/models/${MODEL_NAME}" \
    --use_gpu \
    --device='cuda:0' \
    --output=/output \
    --gvcf \
    --include_all_ctgs


done < clair3.list

echo "all done"
