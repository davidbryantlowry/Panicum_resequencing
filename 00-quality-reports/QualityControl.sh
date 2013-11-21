#!/bin/bash
#SBATCH -J GetQFile_job
#SBATCH -o GetQFile_job.o%j
#SBATCH -e GetQFile_job.e%j
#SBATCH -n 3
#SBATCH -p development
#SBATCH -t 4:00:00
#SBATCH -A #Account number

module load launcher

CMD="Qual-File.param"

EXECUTABLE=$TACC_LAUNCHER_DIR/init_launcher
$TACC_LAUNCHER_DIR/paramrun $EXECUTABLE $CMD