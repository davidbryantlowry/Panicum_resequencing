#!/bin/bash
# Kyle Hernandez
# make-add-rg.sh - Author AddOrReplaceReadGroups job

if [[ -z $1 ]] | [[ -z $2 ]] | [[ -z $3 ]]; then
echo "Usage make-add-rg.sh in/dir/ out/dir/ out.param"
  exit 1;
fi

SCRIPT="/home1/01499/oakglade/bin/picard-tools-1.98/AddOrReplaceReadGroups.jar"
INDIR=$1
ODIR=$2
PARAM=$3
LOG="logs/"

if [ ! -d $ODIR ]; then mkdir $ODIR; fi
if [ ! -d $LOG ]; then mkdir $LOG; fi
if [ -e $PARAM ]; then rm $PARAM; fi
touch $PARAM

# See how easy it is if you submit meaningful sample IDs to GSAF
# JOB_SAMPLE_BAR_LANE_.....sam
for fil in ${INDIR}*_sorted.bam; do
BASE=$(basename $fil)
  NAME=${BASE%.*}
  OUT="${ODIR}${NAME}_RG.bam"
  LOGS="${LOG}${NAME}.log"
  # If your filenames contain all the information but are in different orders,
  # you can simply change the values of the '{print $#}' to whatever index after the
  # split (-F"_" splits on '_'), but remember awk is 1-based index.
  #
  # The GSAF JOB ID we appended to the front
  SAMP=`echo $NAME | awk -F"_" '{print $1}'`
  # The SAMPLEID, which should be the 2nd index
  JOB=`echo $NAME | awk -F"_" '{print $2}'`
  # The BARCODE, which the GSAF should add after the sample ID.
  LIB=`echo $NAME | awk -F"_" '{print $3}'`
  # The LANE, which the GSAF should add after the BAR
  BAR=`echo $NAME | awk -F"_" '{print $4}'`
  # Now you simply add in the variables to the picard command.
  echo -n "java -Xms2G -Xmx3G -jar $SCRIPT INPUT=$fil OUTPUT=$OUT SORT_ORDER=coordinate " >> $PARAM
  # These are the conventions used
  # Remember, I just arbitratily used 'Lib-1' because in a lot of cases we have 1 library/lane and samples are
  # not split across libraries. However, if you do use multiple libraries for a given sample, you must created
  # a library ID and add it to the RGLB
  echo -n "RGID=${SAMP}-${JOB} RGLB=${LIB} RGPL=illumina RGPU=${JOB}-${SAMP}.${BAR} " >> $PARAM
  # RGCN and RGDS aren't required
  # Remember that RGSM is how GATK will find which samples are which, so don't screw this up!
  echo "RGSM=${SAMP} RGCN=JGI RGDS=$NAME > ${LOGS}" >> $PARAM
done