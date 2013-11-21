#!/bin/bash
#SBATCH -J picard_sort_job
#SBATCH -o picard_sort_job.o%j
#SBATCH -e picard_sort_job.e%j
#SBATCH -N 16 
#SBATCH -n 16 
#SBATCH -p normal
#SBATCH -t 10:00:00
#SBATCH -A #Account number

module load launcher
CMD="picard_sort.param"

EXECUTABLE=$TACC_LAUNCHER_DIR/init_launcher
$TACC_LAUNCHER_DIR/paramrun $EXECUTABLE $CMD

echo "DONE";
date;
~                                                                                                                     
~                   