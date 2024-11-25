#!/bin/bash
#cd ../..

# custom config
DATA="/data/usrs/yyr/datasets/lava_dataset"
TRAINER=MaPLe

SEED=$1
DATASET=$2
QUERY=$3
SPLIT=$4
CFG=vit_b16_c2_ep5_batch4_2ctx
SHOTS=16
LOADEP=10
TRAIN_NUM=2000

MODEL_DIR=output/${TRAINER}/object/${DATASET}/${QUERY}/seed${SEED}
# DIR=output/${TRAINER}/full/${DATASET}/query/seed${SEED}
DIR=output
if [ -d "$DIR" ]; then
    echo "Evaluating model"
    echo "Results are available in ${DIR}. Resuming..."

    python baseline/baseline_evaluation.py \
    --root ${DATA} \
    --seed ${SEED} \
    --config ./configs/${DATASET}.yaml \
    --trainer ${TRAINER} \
    --dataset_name ${DATASET} \
    --config-file configs/trainers/${TRAINER}/${CFG}.yaml \
    --output-dir ${DIR} \
    --split ${SPLIT} \
    --model-dir "${MODEL_DIR}" \
    --load-epoch ${LOADEP} \
    --query "${QUERY}" \

else
    echo "Evaluating model"
    echo "Runing the first phase job and save the output to ${DIR}"

    python baseline/baseline_evaluation.py \
    --root ${DATA} \
    --seed ${SEED} \
    --config ./configs/${DATASET}.yaml \
    --trainer ${TRAINER} \
    --dataset_name ${DATASET} \
    --split ${SPLIT} \
    --query "${QUERY}" \
    --config-file configs/trainers/${TRAINER}/${CFG}.yaml \
    --output-dir ${DIR} \
    --model-dir "${MODEL_DIR}" \
    --load-epoch ${LOADEP}
fi