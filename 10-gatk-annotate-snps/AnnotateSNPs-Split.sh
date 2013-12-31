#!/bin/bash
#SBATCH -J annotatejob
#SBATCH -o annotatejob.o%j
#SBATCH -e annotatejob.e%j
#SBATCH -N 110
#SBATCH -n 110
#SBATCH -p normal
#SBATCH -t 12:00:00
#SBATCH -A XXXX


module load launcher
CMD="annotate.param"

EXECUTABLE=$TACC_LAUNCHER_DIR/init_launcher
$TACC_LAUNCHER_DIR/paramrun $EXECUTABLE $CMD

echo "DONE";
date;