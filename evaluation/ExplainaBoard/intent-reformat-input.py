import sys

file = sys.argv[1]
outfile = sys.argv[2]

sent = []
with open(file, "r", encoding="utf-8") as infile, open(outfile, "a", encoding="utf-8") as outfile:
    for line in infile.readlines()[:-1]:
        line = line.strip()

        if line == "":
            outfile.write(f"{sent[1]}\t{sent[0]}\n")
            sent = []

        if line.startswith("#"):
            _, cat, *content = line.split()
            
            if cat == "intent:" or cat == "text:":
                sent.append(" ".join(content))
    
    outfile.write(f"{sent[1]}\t{sent[0]}\n")

    