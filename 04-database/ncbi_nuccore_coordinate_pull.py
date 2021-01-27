#/usr/bin/env python3.7

import subprocess
import argparse
parser = argparse.ArgumentParser()
parser.add_argument('-i', '--input', help='input gene query file')
parser.add_argument('-s', '--subject', help='enter number of subject accession column')
parser.add_argument('-fc', '--forwardcord', help='enter number of forward coordinate column')
parser.add_argument('-rc', '--reversecord', help='enter number of reverse coordinate column')
args = parser.parse_args()

args.subject = int(args.subject) - 1
args.forwardcord = int(args.forwardcord) - 1
args.reversecord = int(args.reversecord) -1

with open(args.input, "r") as f:
    for line in f:
        try:
            record = line.split("\t")
            t=record[2]
        except IndexError:
            break
        record = line.split("\t")
        accession = record[args.subject]
        if int(record[args.forwardcord]) >= int(record[args.reversecord]):
            fwdcoord = int(record[args.reversecord])
            revcoord = int(record[args.forwardcord])
        else:
            fwdcoord = int(record[args.forwardcord])
            revcoord = int(record[args.reversecord].rstrip("\n"))
        subprocess.check_call(['efetch -db nuccore -id %s \
            -seq_start %s \
            -seq_stop %s \
            -format fasta' %(accession, fwdcoord, revcoord)], shell=True )