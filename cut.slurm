#!/bin/bash
#SBATCH --partition=long
#SBATCH --job-name=yaqi_cutbed
#SBATCH --ntasks=1
#SBATCH --mem=50G
#SBATCH --time=00-50:00:00
#SBATCH --output=%j_%x.out
#SBATCH --error=%j_%x.err
#SBATCH --mail-user=yaqi.li@ndcls.ox.ac.uk
#SBATCH --mail-type=end,fail

module load bedtools
zcat /project/higgslab/yli/SNP/DATA/GW_segmentation.bed.gz | bedtools intersect -a stdin -b /project/higgslab/yli/SNP/DATA/hglft_genome_hg19_whole_region.bed > /project/higgslab/yli/SNP/DATA/consHMM_ROI.bed
