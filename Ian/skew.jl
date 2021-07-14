using ArgParse
using BioSequences
using CodecZlib
using FASTX


function skew1(chrom, seq, w)
	for i = 1:length(seq) -w
		g = 0
		c = 0
		for j = i:i+w
			if     seq[j] == DNA_C c += 1
			elseif seq[j] == DNA_G g += 1
			end
		end
		if (g+c) == 0 println("$chrom\t$i\t", 0)
		else          println("$chrom\t$i\t", (g-c)/(g+c))
		end
	end
end

function skew2(chrom, seq, w)
	for i = 1:length(seq) -w
		comp = composition(seq[i:i+w])
		c = comp[DNA_C]
		g = comp[DNA_G]
		if (g+c) == 0 println("$chrom\t$i\t", 0)
		else          println("$chrom\t$i\t", (g-c)/(g+c))
		end
	end
end

function skew3(chrom, seq, w)
	# first window
end


cli = ArgParseSettings()
@add_arg_table! cli begin
	"--window"
		help = "window size"
		arg_type = Int
		default = 100
	"--algorithm"
		help = "1-3"
		arg_type = Int
		default = 1
	"fasta"
		help = "fasta file, required"
		required = true
end
arg = parse_args(ARGS, cli)

reader = nothing
if splitext(arg["fasta"])[2] == ".gz"
	reader = FASTA.Reader(GzipDecompressorStream(open(arg["fasta"])))
else
	reader = FASTA.Reader(open(arg["fasta"]))
end


## Main loop ##
w = arg["window"]
a = arg["algorithm"]
for record in reader
	c = FASTA.identifier(record)
	s = FASTA.sequence(record)
	if     a == 1 skew1(c, s, w)
	elseif a == 2 skew2(c, s, w)
	elseif a == 3 skew3(c, s, w)
	end
end


