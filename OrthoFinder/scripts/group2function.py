import sys
import os
import re

#python group2function.py total_func.txt Orthogroups.csv >tmp
#head total_fun.txt (\t delimited txt)
#Cla000001       Unknown Protein
#head Orghogroups.csv
#        Arabidopsis_thaliana    cucumber        cuscuta glycine_max     watermelon
#OG0000000               Csa2G145890.1, Csa3G263250.1, Csa3G418750.1, Csa3G511970.1, Csa4G569710.1, C

if(len(sys.argv) < 3):
    CRED = '\033[91m'
    CEND = '\033[0m'
    print(CRED + "Usage" + CEND)
    print ("\tpython " + sys.argv[0] + " total_func.txt Orthogroups.csv")
    print (CRED+"Example"+CEND)
    print ("\tpython group2fasta.py total_func.txt Orthogroups.csv")
    exit()

func_file=sys.argv.pop(1)
group_file=sys.argv.pop()

func_dict = {}
with open (func_file) as fh_func:
    for line in fh_func:
        mylist= line.rstrip().split(sep="\t")
        if(len(mylist) < 2):
            mylist.insert(1, "Unknown protein")
        func_dict[mylist[0]] = mylist[1]

#print(record_dict["gi:12345678"])

with open (group_file ) as fh_group:
    header = fh_group.readline()
    print ("GroupID\tAnnotation")
    for line in fh_group:
#        print_buf = line.rstrip() + "\t"
        line_trim = re.sub(',', '', line)
        genes=line_trim.split()
        group_id = genes.pop(0)
        group_id=re.sub(":", "", group_id)
        print_buf = group_id + "\t"
        for gene in genes:
            if(func_dict.__contains__(gene)):
                print_buf = print_buf + func_dict[gene] +"; "
        print(print_buf)
            
