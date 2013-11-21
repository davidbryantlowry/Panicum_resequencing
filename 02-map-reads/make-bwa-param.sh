#!/bin/bash

INDIR="/scratch/01499/oakglade/hallii_jgi/01-filter-reads/round3/"
OUTSAM="/scratch/01499/oakglade/hallii_jgi/02-map-reads/sam/round3/"
SCRIPT="bwa mem"
REF="/scratch/01499/oakglade/hallii_jgi/02-map-reads/Panicum_hallii.main_genome.scaffolds.fasta"
CMD="mapC0K.param"
PRE=$(basename $INDIR)
if [ -e $CMD ]; then rm $CMD; fi
touch $CMD

for fil in ${INDIR}*.fastq; do
  BASE=$(basename $fil)
  NAME=${BASE%.*}
  OFSAM="${OUTSAM}${NAME}.sam"
  echo "$SCRIPT -t 16 -M -p $REF $fil > $OFSAM" >> $CMD
done