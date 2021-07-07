import argparse
import math
import korflib

def dna_entropy(s):
	a, c, g, t = 0, 0, 0, 0
	for nt in s:
		if   nt == 'A': a += 1
		elif nt == 'C': c += 1
		elif nt == 'G': g += 1
		elif nt == 'T': t += 1
	total = a + c + g + t
	if total == 0: return 0
	h = 0
	if a > 0: h -= a/total * math.log2(a/total)
	if c > 0: h -= c/total * math.log2(c/total)
	if g > 0: h -= g/total * math.log2(g/total)
	if t > 0: h -= t/total * math.log2(t/total)
	return h

## Command Line Interface ##

parser = argparse.ArgumentParser(description='dust.py')
parser.add_argument('fasta', type=str, metavar='<file>',
	help='fasta file')                
parser.add_argument('--window', required=False, type=int, default=11,
	metavar='<str>', help='optional string argument [%(default)i]')
parser.add_argument('--entropy', required=False, type=float, default=1.1,
	metavar='<int>', help='optional integer argument [%(default)f]')
parser.add_argument('--lcmask', action='store_true',
	help='on/off switch')
arg = parser.parse_args()

## Main loop ##

w = arg.window
t = arg.entropy

for id, seq in korflib.read_fasta(arg.fasta):
	print(f'>{id}')
	masked = []
	#masked = ''
	for i in range(len(seq) -w + 1):
		h = dna_entropy(seq[i:i+w])
		nt = seq[i]
		if h < t:
			if arg.lcmask: nt = nt.lower()
			else:          nt = 'N'
		masked.append(nt)
		#masked += nt
	print(''.join(masked))
	#print(masked)
	#for i in range(1, len(masked), 50):
	#	print(masked[i:i+50])

# 1 3.0
# 2 5.9
# 4 12.1
# 8 24.9 24.3 24.8


