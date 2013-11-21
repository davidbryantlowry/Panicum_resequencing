#!/bin/bash
# Kyle Hernandez
# make-tobam-index.sh - create parameter file for converting sam to bam and indexing

if [[ -z $1 ]] || [[ -z $2 ]] || [[ -z $3 ]]; then
echo "Usage: make-bam.sh <in/dir> <out/dir> out.param"
        exit 1;
fi

INDIR=$1
ODIR=$2
PARAM=$3
SCRIPT="/home1/01499/oakglade/bin/picard-tools-1.98/BuildBamIndex.jar"
LOG="logs/"

if [ ! -d $LOG ]; then mkdir $LOG; fi
if [ -e $PARAM ]; then rm $PARAM; fi
touch $PARAM

for fil in ${INDIR}*.bam; do
BASE=$(basename $fil)
        NAME=${BASE%.*}
        OUT="${ODIR}${NAME}.bai"
        # Use the CREATE_INDEX=true to also make the idx file
        echo "java -Xms1G -Xmx2G -jar $SCRIPT INPUT=$fil OUTPUT=$OUT" >> $PARAM
done