#####################
# RPOC DATABASE BUILD
#####################
# get annotation and sequences from HOMD
mkdir rpoc
cd rpoc
wget http://www.homd.org/ftp/HOMD_prokka_genomes/tsv/ALL_genomes.tsv
wget http://www.homd.org/ftp/HOMD_prokka_genomes/faa/ALL_genomes.faa
wget http://www.homd.org/ftp/HOMD_prokka_genomes/ffn/ALL_genomes.ffn
wget http://www.homd.org/ftp/HOMD_prokka_genomes/SEQFID_info.txt
grep "rpoC" ALL_genomes.tsv | awk '{print $1}' > rpoc.loc.ids
seqtk subseq ALL_genomes.faa rpoc.loc.ids > HOMD_rpoc.fa

# dereplicate
vsearch --derep_fulllength HOMD_rpoc.fa \
	--output HOMD_rpoc.uniq.fa
# cluster at 99% for tree building
vsearch --sortbylength HOMD_rpoc.uniq.fa \
	--output HOMD_rpoc.sort.fa
vsearch --cluster_fast HOMD_rpoc.sort.fa \
	--centroids HOMD_rpoc.clust.fa \
	--id 0.99
# how many post cluster
grep ">" HOMD_rpoc.clust.fa -c
# 802

# generate taxonomy file for rpoc sequences	
grep ">" HOMD_rpoc.uniq.fa | sed 's/>//' | awk -F"_" '{print $1}' | while read line; do grep -w $line SEQFID_info.txt ; done > taxonomy.txt
# simple taxonomy
awk -F"\t" '{print $1, "\t", $5 "_" $6}' taxonomy.txt > simple_tax.txt
# add in sequence names
paste seqs.ids simple_tax.txt > annotations.txt
# how many strains/species/genera do we pick up?
# strains
cat simple_tax.txt | wc -l
# 1291
# genera
cat simple_tax.txt | awk '{print $2}' | awk -F"_" '{print $1}' | sort | uniq | wc -l
# 152
# species
cat simple_tax.txt | awk '{print $2}' | awk -F"_" '{print $2}' | sort | uniq | wc -l
# 348
# will use this as our constraint tree to better classify our reads after taxonomic assignment using kraken2
# align
mafft --auto HOMD_rpoc.clust.fa > HOMD_rpoc.align.fa
# generate tree
rm ref.tre
raxmlHPC-PTHREADS -T 8 -m GTRCAT -c 25 -e 0.001 -p 31514 -f a -N 100 -x 02938 -n ref.tre -s HOMD_rpoc.align.fa
# looks ok (Mycoplasma is weird but whatcha gonna do)
# now want to blast that database to the full ncbi database to pull any missing taxa
cat HOMD_rpoc.clust.fa | parallel \
	--block 100k \
	--recstart '>' \
	--pipe blastn \
	-evalue 1e-10 \
	-outfmt 6 \
	-db /home/allie/refdb/ncbi/nt \
	-query - > blast.out
# want to pull only those hits that are at least 1k length and 90% identity
awk -F"\t" '$3>=90.0 && $4>=1000' blast.out > good.hits
# now pull sequences by coordinates
# before this have to rearrange output so that start is before start

