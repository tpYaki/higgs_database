#!/bin/bash
#SBATCH --partition=short
#SBATCH --job-name=9_new_v2
#SBATCH --ntasks=1
#SBATCH --mem=10G
#SBATCH --time=00-10:00:00
#SBATCH --output=%j_%x.out
#SBATCH --error=%j_%x.err
#SBATCH --mail-user=yaqi.li@ndcls.ox.ac.uk
#SBATCH --mail-type=end,fail

module load R-cbrg/current

Rscript /project/higgslab/yli/SNP/Script/tissue_change/insilicomut_tissue.R 9 10
