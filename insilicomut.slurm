#!/bin/bash
#SBATCH --partition=short
#SBATCH --job-name=sasquatch
#SBATCH --ntasks=2
#SBATCH --mem=50G
#SBATCH --time=00-10:00:00
#SBATCH --output=%j_%x.out
#SBATCH --error=%j_%x.err
#SBATCH --mail-user=yaqi.li@ndcls.ox.ac.uk
#SBATCH --mail-type=end,fail

module load R-cbrg/current

Rscript insilicomut.R
