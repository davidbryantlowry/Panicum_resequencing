#!/bin/bash
#SBATCH -J Target_job
#SBATCH -o Target_job.o%j
#SBATCH -e Target_job.e%j
#SBATCH -N 6 
#SBATCH -n 6 
#SBATCH -p normal
#SBATCH -t 10:00:00
#SBATCH -A #Account number

module load launcher
CMD="targets.param"

EXECUTABLE=$TACC_LAUNCHER_DIR/init_launcher
$TACC_LAUNCHER_DIR/paramrun $EXECUTABLE $CMD

echo "DONE";
date;