#!/bin/bash
#SBATCH -J curl_job 
#SBATCH -o curl_job.o%j
#SBATCH -e curl_job.e%j
#SBATCH -n 16
#SBATCH -p normal
#SBATCH -t 24:00:00
#SBATCH -A P.hallii_expression

curl https://signon.jgi.doe.gov/signon/create --data-ascii login=<e-mail>\&password=<password> -b cookies -c cookies > /dev/null
curl http://genome.jgi.doe.gov/PanhalGIL42/download/_SDM/51d4d289067c014cd6eb71a4/2247.5.1836.fastq.gz -b cookies -c cookies > GIL42_2247.5.1836.fastq.gz
curl http://genome.jgi.doe.gov/PanhalNOH5/download/_SDM/51d462f6067c014cd6e8a2e9/2051.3.1732.fastq.gz -b cookies -c cookies > NOH5_2051.3.1732.fastq.gz
curl http://genome.jgi.doe.gov/PanhalNOH5/download/_SDM/51d462f5067c014cd6e8a2e6/2051.2.1732.fastq.gz -b cookies -c cookies > NOH5_2051.2.1732.fastq.gz
curl http://genome.jgi.doe.gov/PanhalNOH5/download/_SDM/51d462f4067c014cd6e8a2e3/2051.1.1732.fastq.gz -b cookies -c cookies > NOH5_2051.1.1732.fastq.gz
curl http://genome.jgi.doe.gov/PanhalNOH5/download/_SDM/51d45ff7067c014cd6e89887/1820.7.1625.fastq.gz -b cookies -c cookies > NOH5_1820.7.1625.fastq.gz
curl http://genome.jgi.doe.gov/PanhalNOH5/download/_SDM/51d45ff6067c014cd6e89884/1820.6.1625.fastq.gz -b cookies -c cookies > NOH5_1820.6.1625.fastq.gz
curl http://genome.jgi.doe.gov/PanhalNOH5/download/_SDM/51d45ff5067c014cd6e89881/1820.5.1625.fastq.gz -b cookies -c cookies > NOH5_1820.5.1625.fastq.gz
curl http://genome.jgi.doe.gov/PanhalNMX1/download/_SDM/51d466f3067c014cd6e8b222/2101.4.1757.fastq.gz -b cookies -c cookies > NMX1_2101.4.1757.fastq.gz
curl http://genome.jgi.doe.gov/PanhalNMX1/download/_SDM/51d466f2067c014cd6e8b21f/2101.3.1757.fastq.gz -b cookies -c cookies > NMX1_2101.3.1757.fastq.gz
curl http://genome.jgi.doe.gov/PanhalNMX1/download/_SDM/51d466f0067c014cd6e8b216/2101.2.1757.fastq.gz -b cookies -c cookies > NMX1_2101.2.1757.fastq.gz
curl http://genome.jgi.doe.gov/PanhalNMX1/download/_SDM/51d46349067c014cd6e8a418/2065.5.1739.fastq.gz -b cookies -c cookies > NMX1_2065.5.1739.fastq.gz
curl http://genome.jgi.doe.gov/PanhalNMX1/download/_SDM/51d46348067c014cd6e8a415/2065.4.1739.fastq.gz -b cookies -c cookies > NMX1_2065.4.1739.fastq.gz
curl http://genome.jgi.doe.gov/PanhalNMX1/download/_SDM/51d46347067c014cd6e8a412/2065.3.1739.fastq.gz -b cookies -c cookies > NMX1_2065.3.1739.fastq.gz
curl http://genome.jgi.doe.gov/Panhalsequencing_16/download/_SDM/524b612f067c0136350e4687/7366.7.70188.GGTAGC.fastq.gz -b cookies -c cookies > SMT6_7366.7.70188.GGTAGC.fastq.gz

date;