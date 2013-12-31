#!/bin/bash
# David Lowry
# make-annotate-snp.sh - create parameter file for annotating SNPs for split vcf files


SCRIPT="/home1/01499/oakglade/bin/GenomeAnalysisTK-2.7-2-g6bda569/GenomeAnalysisTK.jar" # Path to GATK, or module load gatk
INDIR="/scratch/01499/oakglade/hallii_combined/08-gatk-indel-realign/realigned/" # Path to realigned bam
VCF="/scratch/01499/oakglade/hallii_combined/09-gatk-first-unified-snps/split-samples/" # Path to split raw-SNP-Q20.vcf files
OUT="/scratch/01499/oakglade/hallii_combined/10-gatk-annotate-snps/"
REF="/scratch/01499/oakglade/hallii_reference/Panicum_hallii.main_genome.scaffolds.fasta" # Path to ref
FILES="files.list"
LOGS="logs/"
PARAM="annotate.param"

if [ -e $FILES ]; then rm $FILES; fi
touch $FILES

for fil in ${INDIR}*.bam; do
echo $fil >> $FILES
done

if [ ! -d $LOG ]; then mkdir $LOG; fi
if [ -e $PARAM ]; then rm $PARAM; fi
touch $PARAM

for fil in ${VCF}*.vcf; do
BASE=$(basename $fil)
        NAME=${BASE%.*}
        OUTPUT="${OUT}${NAME}.vcf"
        LOG="${LOGS}${NAME}.log"
                echo -n "java -Xms2G -Xmx10G -jar $SCRIPT -T VariantAnnotator" >> $PARAM
                echo -n " -I $FILES -G StandardAnnotation -R $REF" >> $PARAM
                echo " -V:variant,VCF $fil -XA SnpEff -o $OUTPUT > $LOG"  >> $PARAM
done