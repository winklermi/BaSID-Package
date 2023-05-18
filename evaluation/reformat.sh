#!/bin/bash

modelpath=$1
# extracts the model name from the modelpath variable
modelname=${modelpath#*/logs/}
modelname=${modelname%%/*}

set=$2
lang=$3
data="eval-data/$lang.$set.conll"

result="results/$modelname/$set/$modelname.$lang.$set.predict.out"

# if the dataset has not yet been reformatted, reformat for slots
if ! test -f "ExplainaBoard/eb-slots.$lang.$set.conll"; then
    eb_slots_infile="ExplainaBoard/eb-slots.$lang.$set.conll"
    touch $eb_slots_infile
    python3 ExplainaBoard/slot-reformat.py $data $eb_slots_infile
fi

# if the dataset has not yet been reformatted, reformat for intents
if ! test -f "ExplainaBoard/eb-intents.$lang.$set.conll"; then
    eb_intents_infile="ExplainaBoard/eb-intents.$lang.$set.tsv"
    touch $eb_intents_infile
    python3 ExplainaBoard/intent-reformat-input.py $data $eb_intents_infile
fi


# prepare the directory and file for the explainaboard slot f1 files
mkdir -p ExplainaBoard/slots/$modelname/$lang
eb_slots_outfile="ExplainaBoard/slots/$modelname/$lang/eb-slots.out.$modelname.$lang.$set.conll"
touch $eb_slots_outfile

# prepare the directory and file for the explainaboard intent accuracy files
mkdir -p ExplainaBoard/intents/$modelname/$lang
eb_intents_outfile="ExplainaBoard/intents/$modelname/$lang/eb-intents.out.$modelname.$lang.$set.txt"
touch $eb_intents_outfile

# reformat the prediction file for use in explainaboard
echo "Reformatting the prediction for ExplainaBoard..."

python3 ExplainaBoard/slot-reformat.py $result $eb_slots_outfile
python3 ExplainaBoard/intent-reformat-output.py $result $eb_intents_outfile

echo "Prediction reformated. Files are ready for use in ExplainaBoard"