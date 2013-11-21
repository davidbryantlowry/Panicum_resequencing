#!/bin/bash
#SBATCH -J bwa_job
#SBATCH -o bwa_job.o%j
#SBATCH -e bwa_job.e%j
#SBATCH -N 16
#SBATCH -n 16
#SBATCH -p normal
#SBATCH -t 12:00:00
#SBATCH -A #Account number

module load launcher
module load bwa
CMD="mapC0K.param"

EXECUTABLE=$TACC_LAUNCHER_DIR/init_launcher
$TACC_LAUNCHER_DIR/paramrun $EXECUTABLE $CMD

echo "DONE";
date;
