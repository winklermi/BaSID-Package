#!/bin/bash

modelpath=$1
# extracts the model name from the modelpath variable
modelname=${modelpath#*/logs/}
modelname=${modelname%%/*}

lang=$2
set=$3
data="eval-data/$lang.$set.conll"

result="results/$modelname/$set/$modelname.$lang.$set.predict.out"

# if the dataset has not yet been reformatted, reformat
if ! test -f "ExplainaBoard/eb.$lang.$set.conll"; then
    eb_infile="ExplainaBoard/eb.$lang.$set.conll"
    touch $eb_infile
    python3 ExplainaBoard/reformat.py $data $eb_infile
fi

# prepare the directory and file for the explainaboard files
mkdir -p ExplainaBoard/$modelname/$set
eb_outfile="ExplainaBoard/$modelname/$set/eb.out.$modelname.$lang.$set.conll"
touch $eb_outfile

# reformat the prediction file for use in explainaboard
echo "Reformatting the prediction for ExplainaBoard..."

python3 ExplainaBoard/reformat.py $result $eb_outfile

echo "Prediction reformated. File $eb_outfile is ready for use in ExplainaBoard"