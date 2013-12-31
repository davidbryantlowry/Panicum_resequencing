#!/bin/bash

INDIR="/scratch/01499/oakglade/hallii_combined/11-gatk-first-unified-indel/split-samples/"
OUT="/scratch/01499/oakglade/hallii_combined/11-gatk-first-unified-indel/rawINDEL-Q20.vcf"
REF="/scratch/01499/oakglade/hallii_reference/Panicum_hallii.main_genome.scaffolds.fasta"
JOB="CatAllVariants.job"
INTERVALS="/scratch/01499/oakglade/hallii_combined/09-gatk-first-unified-snps/split-samples/intervals/"
GATK="/home1/01499/oakglade/bin/GenomeAnalysisTK-2.7-2-g6bda569/"

if [ -e $JOB ]; then rm $JOB; fi
touch $JOB

# Write out the header to the job script
echo "#!/bin/bash" >> $JOB
echo "#SBATCH -J cat_allvariantsjob" >> $JOB
echo "#SBATCH -o cat_allvariantsjob.o%j" >> $JOB
echo "#SBATCH -e cat_allvariantsjob.e%j" >> $JOB
echo "#SBATCH -n 16" >> $JOB
echo "#SBATCH -p development" >> $JOB
echo "#SBATCH -t 04:00:00" >> $JOB
echo "#SBATCH -A P.hallii_expression" >> $JOB
echo "" >> $JOB
# Start writing out the java stuff to run the CatVariants function.
# It isnÕt a traditional -T tool, you have to load the class path with -cp as seen below
# Remember my ${GATK} variable is an environmental variable I have in my ~/.bash_profile that is simply the path to my GATK directory
echo "java -Xms5G -Xmx25G \\" >> $JOB
echo "-cp ${GATK}GenomeAnalysisTK.jar org.broadinstitute.sting.tools.CatVariants \\" >> $JOB
echo "-R $REF \\" >> $JOB

# Now we write out each vcf file in the correct (genome coordinate) order
for fil in ${INTERVALS}*.intervals; do
  BASE=$(basename $fil)
  NAME=${BASE%.*}
  echo "-V ${INDIR}rawINDEL-Q20-${NAME}.vcf \\" >> $JOB
done

echo "-out $OUT \\" >> $JOB
echo "-assumeSorted" >> $JOB