#!/bin/bash
# Kyle Hernandez
# Edited by David Lowry
# make-recalibrate.sh - create parameter files for base recalibration. Multi step.


SCRIPT="/home1/01499/oakglade/bin/GenomeAnalysisTK-2.7-2-g6bda569/GenomeAnalysisTK.jar"
INHQ="/scratch/01499/oakglade/hallii_combined/13-gatk-hq-snps/"
INRA="/scratch/01499/oakglade/hallii_combined/08-gatk-indel-realign/realigned/"
REF="/scratch/01499/oakglade/hallii_reference/Panicum_hallii.main_genome.scaffolds.fasta"
GRP="/scratch/01499/oakglade/hallii_combined/14-gatk-base-recalibrator/group/"
BAM="/scratch/01499/oakglade/hallii_combined/14-gatk-base-recalibrator/recal-bam/"
LOG="logs/"
# Need one parameter file for each step
BPARAM="base-recal.param"
PPARAM="print-reads.param"

if [ ! -d $LOG ]; then mkdir $LOG; fi
if [ -e $BPARAM ]; then rm $BPARAM; fi
if [ -e $PPARAM ]; then rm $PPARAM; fi
touch $BPARAM
touch $PPARAM

# Loop through the indel realigned bam folder
for fil in ${INRA}*.bam; do
BASE=$(basename $fil)
    NAME=${BASE%_*}
    # HQ VCF file for this sample
    VCF="${INHQ}${NAME}_HQ.vcf"
    # Output recalibrator group file
    OGRP="${GRP}${NAME}_recal.grp"
    # Output recalibrator bam file
    OBAM="${BAM}${NAME}_recal.bam"
    # Logs
    GLOG="${LOG}${NAME}_group.log"
    BLOG="${LOG}${NAME}_print.log"
    # First we do base recal groups
    # These do like more RAM
    echo -n "java -Xms10G -Xmx20G -jar $SCRIPT -T BaseRecalibrator -I $fil -R $REF " >> $BPARAM
    echo "-knownSites $VCF -o $OGRP > $GLOG" >> $BPARAM

    # Then we print recalibrated BAM file
    echo -n "java -Xms10G -Xmx20G -jar $SCRIPT -T PrintReads -I $fil -R $REF " >> $PPARAM
    echo "-BQSR $OGRP -o $OBAM > $BLOG" >> $PPARAM
done