import random
random.seed(1)
dna = "ACTG"
size = 46000
genome = ''
for i in range(size):
	genome += random.choice(dna)
print(genome)

orfs = {}
for i in range(len(genome)-1):
	codon = genome[i:i+3]
	if codon == 'ATG':
		for j in range(i, len(genome)-2, 3):
			codon = genome[j:j+3]
			print(codon, end='')
			if codon == 'TAA' or codon == 'TAG' or codon =='TGA':break
		length = j-i
		if length not in orfs: orfs[length] = 1
		else: orfs[length] += 1

for l in orfs:
	print(l, orfs[l])
#write in julia
