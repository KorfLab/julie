using ArgParse
using BioSequences
using CodecZlib
using FASTX

cli = ArgParseSettings()
@add_arg_table cli begin
	"--window"
		help = "window size"
		arg_type = Int
		default = 100
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
for record in reader
	chrom = FASTA.identifier(record)
	dna_seq = FASTA.sequence(record)
	println(length(dna_seq))
	for i = 1:length(dna_seq)-w
		g = 0
		c = 0
		for j = i:i+w
			if 	   dna_seq[j] == DNA_C c+=1
			elseif dna_seq[j] == DNA_G g+=1
			end	
		end	
		println("$chrom\t$i\t", (g-c)/(g+c))	
	end
end
