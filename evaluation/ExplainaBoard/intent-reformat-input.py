import sys

file = sys.argv[1]
outfile = sys.argv[2]

sent = {}
with open(file, "r", encoding="utf-8") as infile, open(outfile, "a", encoding="utf-8") as outfile:
    for line in infile.readlines()[:-1]:
        line = line.strip()

        if line == "":
            outfile.write(f"{sent.get('sentence')}\t{sent.get('intent')}\n")
            sent = {}

        if line.startswith("#"):
            _, cat, *content = line.split()
            
            if cat == "intent:":
                sent['intent'] = " ".join(content)

            if cat == "text:":
                sent['sentence'] = " ".join(content)
    
    outfile.write(f"{sent.get('sentence')}\t{sent.get('intent')}\n")

    