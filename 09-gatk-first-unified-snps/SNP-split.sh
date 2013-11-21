#!/bin/bash
#SBATCH -J Unified_job
#SBATCH -o Unified_job.o%j
#SBATCH -e Unified_job.e%j
#SBATCH -N 13
#SBATCH -n 13 
#SBATCH -p normal
#SBATCH -t 14:00:00
#SBATCH -A #Account number

module load launcher
CMD="snp-splits.param"

EXECUTABLE=$TACC_LAUNCHER_DIR/init_launcher
$TACC_LAUNCHER_DIR/paramrun $EXECUTABLE $CMD

echo "DONE";
date;