#!/bin/bash

for i in `ls -d */ |sed 's/\///'`
     do bsub "tar -czf ../result/$i.result.tgz $i/result/*.gene_alignment_ratio.xls $i/result/*.gene_expression.xls $i/result/*.gene_DE.func.*.xls $i/result/*.pdf "
      done
