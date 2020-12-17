## **In silico** primer testing using [Primer Prospector](http://pprospector.sourceforge.net/)

First need to create the conda environment for primer prospector (python v.2.7)

```bash
conda env create environment.yml
```

After it is installed, activate the environment

```bash
conda activate pprospector_rpoc
```

Download the HOMD genome reference database

```bash
wget http://www.homd.org/ftp/HOMD_prokka_genomes/fna/ALL_genomes.fna
```

We can now use primer prospector to analyze our different primer sets against the HOMD. First let's test our 16S primers (515f/806r).

```bash
analyze_primers.py -f ALL_genomes.fna -p 515f -s GTGCCAGCMGCCGCGGTAA &
analyze_primers.py -f ALL_genomes.fna -p 806r -s GGACTACHVGGGTWTCTAAT &
```

Testing **Streptococcus** specific 30S primers

```bash
analyze_primers.py -f ALL_genomes.fna -p Strep30Sf -s ATGTCACGTATYGGTAATAA &
analyze_primers.py -f ALL_genomes.fna -p Strep30Sr -s WGTYTTACCTTCYTTRMGRCGDA &
```

Testing **Streptococcus** specific rpoC primers

```bash
analyze_primers.py -f ALL_genomes.fna -p rpoCStrepf_VPR-1 -s AAYGARAARCGDATGYTNCARGA &
analyze_primers.py -f ALL_genomes.fna -p rpoCStrepr_VPR-1 -s GCCATYTGGTCNCCRTCRAA &
```

Finally, test community rpoC primers

```bash
analyze_primers.py -f ALL_genomes.fna -p rpoCPLQf_3 -s MAYGARAARMGNATGYTNCARGA &
analyze_primers.py -f ALL_genomes.fna -p rpoCPLQr_1 -s GMCATYTGRTCNCCRTCRAA &
```

These should take some time to complete and will throw an error message when primer prospector is supposed to generate figures (this is fine and won't impact downstream analyses). Once they are complete we can get predicted amplicons for each primer set.

16S primers

```bash
get_amplicons_and_reads.py -f ALL_genomes.fna -i 515f_ALL_genomes_hits.txt:806r_ALL_genomes_hits.txt &
```

30S primers

```bash
get_amplicons_and_reads.py -f ALL_genomes.fna -i Strep30Sf_ALL_genomes_hits.txt:Strep30Sr_ALL_genomes_hits.txt &
```

**Streptococcus** rpoC primers

```bash
get_amplicons_and_reads.py -f ALL_genomes.fna -i rpoCStrepf_VPR-1_ALL_genomes_hits.txt:rpoCStrepr_VPR-1_ALL_genomes_hits.txt &
```

Community rpoC primers

```bash
get_amplicons_and_reads.py -f ALL_genomes.fna -i rpoCPLQf_3_ALL_genomes_hits.txt:rpoCPLQr_1_ALL_genomes_hits.txt &
```

Generate trees for each predicted amplicon set

```bash
```

Now we can generate some statistics about these predicted amplicons.

```bash

```



