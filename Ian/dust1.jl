using ArgParse
using BioSequences
using CodecZlib
using FASTX


function dna_entropy(s)
	a, c, g, t = 0, 0, 0, 0
	for nt in s
		if     nt == DNA_A a += 1
		elseif nt == DNA_C c += 1
		elseif nt == DNA_G g += 1
		elseif nt == DNA_T t += 1
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
	seq = FASTA.sequence(record)
	
	# generate masked sequence
	masked = String[]
	for i in 1 : length(seq) -w
		if haskey(bio2ascii, seq[i]) nt = bio2ascii[seq[i]]
		else                         nt = "N"
		end
		h = dna_entropy(seq[i:i+w])
		if h < t
			if arg["lcmask"] nt = lowercase(nt)
			else             nt = "N"
			end
		end
		push!(masked, nt)
	end
	
	# output masked sequence (except the final window currently)
	s = join(masked)
	#println(masked)
	#for i in 1:50:length(s)
	#	if i+50 > length(s) println(s[i:end])
	#	else                println(s[i:i+50])
	#	end
	#end

end

# 1x 14.6
# 2x 16.8
# 4x 23.5
# 8x 36.7 14.7 17.9

