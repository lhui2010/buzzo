import sys
import json

sys.argv.pop(0)
selected_list = {}
    
for file_name in sys.argv:
    with open(file_name) as fd: 
        doc = json.load(fd)
        if(doc["test results"]["positive test results"] > 0 ):
            for fish in doc["branch attributes"]["0"].keys():
                if(doc["branch attributes"]["0"][fish]["Corrected P-value"] < 0.05):
                    selected_list[fish] = doc["branch attributes"]["0"][fish]["Corrected P-value"]

for gene in selected_list.keys():
    print (gene + "\t" + str(selected_list[gene]))
