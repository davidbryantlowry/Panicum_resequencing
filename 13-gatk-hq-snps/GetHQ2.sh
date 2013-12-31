#!/bin/bash
#SBATCH -J HQ_job # Job Name
#SBATCH -o HQ_job.o%j # Output file name (%j expands to jobID)
#SBATCH -e HQ_job.e%j # Error file name (%j expands to jobID)
#SBATCH -n 16
#SBATCH -p development
#SBATCH -t 04:00:00 # Run time (hh:mm:ss) - 1.5 hours
#SBATCH -A XXXX

# You must do this
module load python

# Globals
SCRIPT="python /scratch/01499/oakglade/hallii_combined/bin/13-gatk-hq-snps/GetHighQualVcfs.py" # Path to GetHighQualVcf.py
INDIR="/scratch/01499/oakglade/hallii_combined/12-gatk-filter-snps/only-PASS-Q30-SNPS.vcf" # Path to only-PASS-Q30-SNPS.vcf
ODIR="/scratch/01499/oakglade/hallii_combined/13-gatk-hq-snps/" # Path to high quality snps directory

$SCRIPT -i $INDIR -o $ODIR

echo "DONE"
date;