#!/bin/bash
#SBATCH -J picard_merge_job
#SBATCH -o picard_merge_job.o%j
#SBATCH -e picard_merge_job.e%j 
#SBATCH -n 6
#SBATCH -p development
#SBATCH -t 4:00:00
#SBATCH -A #Account number

module load launcher
CMD="merge.param"

EXECUTABLE=$TACC_LAUNCHER_DIR/init_launcher
$TACC_LAUNCHER_DIR/paramrun $EXECUTABLE $CMD

echo "DONE";
date;