#!/bin/bash

modelpath=$1
modelname=${modelpath#*/logs/}
modelname=${modelname%%/*}

lang=$2
set=$3
data="eval-data/$lang.$set.conll"

mkdir -p results/$modelname/$set

result="results/$modelname/$set/$modelname.$lang.$set.predict.out"

touch $result

echo "Starting MaChAmp Prediction..."

python3 machamp/predict.py $modelpath $data $result --device 0 --dataset SID

echo "Prediction Successful"
echo "Starting Evaluation..."

python3 sidEval.py $data $result
python3 sidEval.py $data $result > results/$modelname/$set/$modelname.$lang.$set.eval.out

echo "Evaluation Successful"
echo "Files can be found in results/$modelname/$set" 
