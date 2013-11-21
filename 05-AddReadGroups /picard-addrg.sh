#!/bin/bash
#SBATCH -J picard_addrg_job
#SBATCH -o picard_addrg_job.o%j
#SBATCH -e picard_addrg_job.e%j 
#SBATCH -n 10
#SBATCH -p development
#SBATCH -t 4:00:00
#SBATCH -A #Account number

module load launcher
CMD="add_rg.param"

EXECUTABLE=$TACC_LAUNCHER_DIR/init_launcher
$TACC_LAUNCHER_DIR/paramrun $EXECUTABLE $CMD

echo "DONE";
date;