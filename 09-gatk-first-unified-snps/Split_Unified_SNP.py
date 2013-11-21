import os
import itertools
import glob

contigs   = "/scratch/01499/oakglade/hallii_reference/contigs.txt"
ref       = "/scratch/01499/oakglade/hallii_reference/Panicum_hallii.main_genome.scaffolds.fasta"
intervals = "/scratch/01499/oakglade/hallii_combined/09-gatk-first-unified-snps/split-samples/intervals/"
logs      = "/scratch/01499/oakglade/hallii_combined/bin/09-gatk-first-unified-snps/split-contigs/logs/"
indir     = "/scratch/01499/oakglade/hallii_combined/08-gatk-indel-realign/realigned/"
odir      = "/scratch/01499/oakglade/hallii_combined/09-gatk-first-unified-snps/split-samples/"
param     = "snp-splits.param"
script    = "java -Xms2G -Xmx25G -jar /home1/01499/oakglade/bin/GenomeAnalysisTK-2.7-2-g6bda569/GenomeAnalysisTK.jar " + \
            "-T UnifiedGenotyper -nct 4 -nt 4"
filters   = "--read_filter BadMate --read_filter NotPrimaryAlignment " + \
            "--read_filter DuplicateRead --read_filter MappingQualityZero -glm SNP " + \
            "-gt_mode DISCOVERY -maxAltAlleles 6 -stand_call_conf 20 -stand_emit_conf 20"

# grouper helper
def grouper(n, iterable, fillvalue=None):
    args = [iter(iterable)] * n
    return itertools.izip_longest(*args, fillvalue=fillvalue)

# Get scaffolds
scaffolds = [j.rstrip() for j in open(contigs, 'rU')]

# Get the bigger scaffolds first
first = scaffolds[0:240]
# The rest second
rest  = scaffolds[240::]

# write files list
with open("files.list", 'wb') as o:
    flist = glob.glob(indir + "*.bam")
    for fil in sorted(flist):
        o.write(os.path.abspath(fil) + '\n')
o.close()

# Counts for characters
at = 97
ct = 97

# Open parameter file
o_par = open(param, 'wb')
# Process big scaffolds first in groups of 20
for k in grouper(10, first):
    name = "contig-" + chr(at) + chr(ct)
    o_int = os.path.join(intervals, name + ".intervals")
    o_ctg = open(o_int, 'wb')
    o_ctg.write("\n".join([i for i in k if i]) + "\n")
    o_ctg.close

    olog = logs + name + ".log"
    o_fil = os.path.join(odir, "rawSNP-Q20-" + name + ".vcf")

    o_par.write("{0} -L {1} -I files.list -R {2} {3} -o {4} > {5}\n".format(
      script, o_int, ref, filters, o_fil, olog))

    if ct < 122:
        ct += 1
    else:
        ct = 97
        at += 1

# Process smaller scaffolds now in groups of 100
for k in grouper(100, rest):
    name = "contig-" + chr(at) + chr(ct)
    o_int = os.path.join(intervals, name + ".intervals")
    o_ctg = open(o_int, 'wb')
    o_ctg.write("\n".join([i for i in k if i]) + "\n")
    o_ctg.close

    olog = logs + name + ".log"
    o_fil = os.path.join(odir, "rawSNP-Q20-" + name + ".vcf")

    o_par.write("{0} -L {1} -I files.list -R {2} {3} -o {4} > {5}\n".format(
      script, o_int, ref, filters, o_fil, olog))

    if ct < 122:
        ct += 1
    else:
        ct = 97
        at += 1
o_par.close()
