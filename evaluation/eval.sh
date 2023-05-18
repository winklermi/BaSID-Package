#!/bin/bash

modelpath=$1
# extracts the model name from the modelpath variable
modelname=${modelpath#*/logs/}
modelname=${modelname%%/*}

set=$2
lang=$3
data="eval-data/$lang.$set.conll"

# prepare the directory and file for the prediction
mkdir -p results/$modelname/$set
result="results/$modelname/$set/$modelname.$lang.$set.predict.out"
touch $result


# start prediction with predict.py
echo "Starting MaChAmp Prediction..."

python3 ../machamp/predict.py $modelpath $data $result --device 0 --dataset SID

echo "Prediction Successful"

# evaluate the prediction with sidEval.py
echo "Starting Evaluation..."

python3 sidEval.py $data $result
python3 sidEval.py $data $result > results/$modelname/$set/$modelname.$lang.$set.eval.out

echo "Evaluation Successful"

# done
echo "Files can be found in results/$modelname/$set" 
