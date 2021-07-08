#!/bin/bash -l
#SBATCH --job-name=tools
#SBATCH --output=tools_%j.log
#SBATCH --time=20:00:00
#SBATCH --ntasks=1
#SBATCH --mail-type=ALL
#SBATCH --mail-user=li002252@umn.edu
#SBATCH -p amd
cd $SLURM_SUBMIT_DIR
date;hostname;pwd


set -o nounset 
set -o errexit 
set -x 

# creat samples.tsv
python workflow/scripts/simulator.py
snakemake --cluster "sbatch  --partition=amd --nodes=1  --time=10:00:00 --mem=30gb --mail-user=li002252@umn.edu" -s workflow/Snakefile -j 2
