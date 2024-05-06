#!/bin/bash

#awk 'BEGIN{OFS="\t"} {print $1, $2, $3; for(i=4; i<=NF; i++) printf "%s%s", $i, (i<NF?OFS:ORS)}' /project/higgslab/yli/SNP/DATA/jarvis > /project/higgslab/yli/SNP/DATA/jarvis.bed
awk 'BEGIN{OFS="\t"} {print $1, $2, $3, $4}' /project/higgslab/yli/SNP/DATA/jarvis > /project/higgslab/yli/SNP/DATA/jarvis.bed
awk 'BEGIN{FS=","; OFS="\t"} {printf("%s\t%s\t%s", $1, $2, $3); for(i=4; i<=NF; i++) printf("%s%s", OFS, $i); print ""}' Clivar_snp.csv > Clivar_snp.bed


# Command to annotate fileA.bed with the third column of fileB.bed
bedtools intersect -a /project/higgslab/yli/SNP/DATA/Clivar_snp.bed -b /project/higgslab/yli/SNP/DATA/jarvis.bed -wb | awk '{print $0, $(NF-2)}'

