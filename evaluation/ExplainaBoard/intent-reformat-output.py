import sys

file = sys.argv[1]
outfile = sys.argv[2]

with open(file, "r", encoding="utf-8") as infile, open(outfile, "a", encoding="utf-8") as outfile:
    for line in infile.readlines():
        line = line.strip()

        if line == "":
            outfile.write("\n")

        if line.startswith("# intent:"):
            _, _, intent = line.split()
            outfile.write(intent)

    