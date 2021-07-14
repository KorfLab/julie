import argparse
import math
import korflib
import sys

def skew1(chrom, seq, w):
	for i in range(len(seq) -w+1):
		g = 0
		c = 0
		for j in range(i, i+w):
			if   seq[j] == 'C': c += 1
			elif seq[j] == 'G': g += 1
		if (g+c) == 0: print(chrom, i, 0, sep='\t')
		else:          print(chrom, i, (g-c)/(g+c), sep='\t')

def skew2(chrom, seq, w):
	for i in range(len(seq) -w+1):
		g = seq[i:i+w].count('G')
		c = seq[i:i+w].count('C')
		if (g+c) == 0: print(chrom, i, 0, sep='\t')
		else:          print(chrom, i, (g-c)/(g+c), sep='\t')

def skew3(chrom, seq, w):
	# first window
	g = seq[:w].count('G')
	c = seq[:w].count('C')
	print(chrom, 0, (g-c)/(g+c), sep='\t')
	# all other windows
	for i in range(1, len(seq) -w):
		off = seq[i-1]
		on  = seq[i+w-1]
		
		if   off == 'C': c -= 1
		elif off == 'G': g -= 1
		
		if   on == 'C': c += 1
		elif on == 'G': g += 1
		
		if (g+c) == 0: print(chrom, i, 0, sep='\t')
		else:          print(chrom, i, (g-c)/(g+c), sep='\t')
		


## Command Line Interface ##

parser = argparse.ArgumentParser(description='skew.py')
parser.add_argument('fasta', type=str, metavar='<file>', help='fasta file')                
parser.add_argument('--window', required=False, type=int, default=11,
	metavar='<str>', help='window size, must be odd [%(default)i]')
parser.add_argument('--algorithm', required=False, type=int, default=1,
	metavar='<int>', help='1-3 [%(default)i]')
arg = parser.parse_args()


## Main loop ##
w = arg.window
a = arg.algorithm
for id, seq in korflib.read_fasta(arg.fasta):
	if   a == 1: skew1(id, seq, w)
	elif a == 2: skew2(id, seq, w)
	elif a == 3: skew3(id, seq, w)
	


