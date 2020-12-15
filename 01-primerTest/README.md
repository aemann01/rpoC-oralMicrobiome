## **In silico** primer testing using [Primer Prospector](http://pprospector.sourceforge.net/)

First need to create the conda environment for primer prospector (python v.2.7)

```bash
conda env create environment.yml
```

After it is installed, activate the environment

```bash
conda activate pprospector_rpoc
```

We can now use primer prospector to analyze our different primer sets against a database of curate oral microbes. First let's test our 16S primers (515f/806r).

```bash
analyze_primers.py -f ~/refDB/vince_oral_genomes/n4584.fnn -p 515f -s GTGCCAGCMGCCGCGGTAA &
analyze_primers.py -f ~/refDB/vince_oral_genomes/n4584.fnn -p 806r -s GGACTACHVGGGTWTCTAAT &
```

Testing **Streptococcus** specific 30S primers

```bash
analyze_primers.py -f ~/refDB/vince_oral_genomes/n4584.fnn -p Strep30Sf -s ATGTCACGTATYGGTAATAA &
analyze_primers.py -f ~/refDB/vince_oral_genomes/n4584.fnn -p Strep30Sr -s WGTYTTACCTTCYTTRMGRCGDA &
```

Testing **Streptococcus** specific rpoC primers

```bash
analyze_primers.py -f ~/refDB/vince_oral_genomes/n4584.fnn -p rpoCf_strep_VPR-1 -s AAYGARAARCGDATGYTNCARGA &
analyze_primers.py -f ~/refDB/vince_oral_genomes/n4584.fnn -p rpoCr_strep_VPR-1 -s GCCATYTGGTCNCCRTCRAA &
```

Finally, test community rpoC primers

```bash
analyze_primers.py -f ~/refDB/vince_oral_genomes/n4584.fnn -p rpoCf_PLQ_3 -s MAYGARAARMGNATGYTNCARGA &
analyze_primers.py -f ~/refDB/vince_oral_genomes/n4584.fnn -p rpoCr_PLQ_1 -s GMCATYTGRTCNCCRTCRAA &
```

These should take some time to complete and will throw an error message when primer prospector is supposed to generate figures (this is fine and won't impact downstream analyses). Once they are complete we can get predicted amplicons for each primer set.

16S primers

```bash

```

30S primers

```bash

```

**Streptococcus** rpoC primers

```bash

```

Community rpoC primers

```bash

```
