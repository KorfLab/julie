using ArgParse
using BioSequences
using CodecZlib
using FASTX


function dna_entropy(s)
	a, c, g, t = 0, 0, 0, 0
	for nt in s
		if     nt == 'A' a += 1
		elseif nt == 'C' c += 1
		elseif nt == 'G' g += 1
		elseif nt == 'T' t += 1
		end
	end
	total = a + c + g + t
	if total == 0 return 0 end
	h = 0
	if a > 0 h -= a/total * log2(a/total) end
	if c > 0 h -= c/total * log2(c/total) end
	if g > 0 h -= g/total * log2(g/total) end
	if t > 0 h -= t/total * log2(t/total) end
	return h
end

bio2ascii = Dict{DNA, String}(
	DNA_A => "A",
	DNA_C => "C",
	DNA_G => "G",
	DNA_T => "T",
	DNA_N => "N",
)

## Command Line Interface ##

cli = ArgParseSettings()
@add_arg_table cli begin
	"--window"
		help = "window size"
		arg_type = Int
		default = 11
	"--entropy"
		help = "entropy threshold"
		arg_type = Float64
		default = 1.1
	"--lcmask"
		help = "mask using lowercase rather than N"
		action = :store_true
	"fasta"
		help = "fasta file, required"
		required = true
end
arg = parse_args(ARGS, cli)

## FASTA reader setup ##

reader = nothing
if splitext(arg["fasta"])[2] == ".gz"
	reader = FASTA.Reader(GzipDecompressorStream(open(arg["fasta"])))
else
	reader = FASTA.Reader(open(arg["fasta"]))
end

## Main loop ##

w = arg["window"]
t = arg["entropy"]

for record in reader
	println(">", FASTA.identifier(record))
	dna_seq = FASTA.sequence(record)
	# comparing conversion speeds...
	
	chars = String[]
	for i in 1 : length(dna_seq)
		if haskey(bio2ascii, dna_seq[i]) nt = bio2ascii[dna_seq[i]]
		else                             nt = "N"
		end
		push!(chars, nt)
	end
	seq = join(chars)
	
	"""
	
	chars = String[]
	for i in 1 : length(dna_seq)
		if haskey(bio2ascii, dna_seq[i]) nt = bio2ascii[dna_seq[i]]
		else                             nt = "N"
		end
		push!(chars, nt)
	end
	seq = join(chars)
	
	# generate masked sequence
	masked = Char[]
	for i in 1 : length(seq) -w
		h = dna_entropy(seq[i:i+w])
		nt = seq[i]
		if h < t
			if arg["lcmask"] nt = lowercase(nt)
			else             nt = 'N'
			end
		end
		push!(masked, nt)
	end
	
	# output masked sequence (except the final window currently)
	s = join(masked)
	println(s)
	#for i in 1:50:length(s)
	#	if i+50 > length(s) println(s[i:end])
	#	else                println(s[i:i+50])
	#	end
	#end
	
	"""

end

"""

A	read sequence in
B	convert sequence to String array and join

	 A    B     C
1	8.7  9.2
2	8.9  9.3
4	8.8  9.7
8	8.7 11.0
16	8.9 12.8


"""



