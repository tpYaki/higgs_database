#!/bin/bash
#SBATCH --partition=long
#SBATCH --job-name=yaqi_bedgraph
#SBATCH --ntasks=1
#SBATCH --mem=50G
#SBATCH --time=00-50:00:00
#SBATCH --output=%j_%x.out
#SBATCH --error=%j_%x.err
#SBATCH --mail-user=yaqi.li@ndcls.ox.ac.uk
#SBATCH --mail-type=end,fail

module load bedtools
awk 'BEGIN{FS=OFS="\t"} {sub(/^U/, "", $4); print}' /project/higgslab/datashare/yli/consHMM_ROI.bed > /project/higgslab/datashare/yli/modified_consHMM_ROI.bed
awk '{OFS="\t"; print $1, $2, $3, $4, $4}' /project/higgslab/datashare/yli/modified_consHMM_ROI.bed > /project/higgslab/datashare/yli/modified_consHMM_ROI2.bed
bedtools genomecov -i /project/higgslab/datashare/yli/modified_consHMM_ROI2.bed -bg -g /project/higgslab/datashare/yli/hg19.chrom.sizes > /project/higgslab/datashare/yli/modified_consHMM_ROI.bedGraph
