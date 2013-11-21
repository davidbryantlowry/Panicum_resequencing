#!/bin/bash
#SBATCH -J sam_filter_job
#SBATCH -o sam_filter_job.o%j
#SBATCH -e sam_filter_job.e%j
#SBATCH -n 12
#SBATCH -p normal
#SBATCH -t 08:00:00
#SBATCH -A #Account number

module load launcher
module load samtools
CMD="filter_sam.param3"

EXECUTABLE=$TACC_LAUNCHER_DIR/init_launcher
$TACC_LAUNCHER_DIR/paramrun $EXECUTABLE $CMD

echo "DONE";
date;