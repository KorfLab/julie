using ArgParse
using BioSequences
using CodecZlib
using FASTX
## Command Line Interface ##
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
## FASTA reader setup ##

reader = nothing
if splitext(arg["fasta"])[2] == ".gz"
	reader = FASTA.Reader(GzipDecompressorStream(open(arg["fasta"])))
else
	reader = FASTA.Reader(open(arg["fasta"]))
end

## Main loop ##
w = arg["window"]
for record in reader
	#println(">", FASTA.identifier(record))
	chrom = FASTA.sequence(record)
	println(length(dna_seq)) #tell length of every one of the sequenes: run skew.jl test.fa 
	for i = 1:length(dna_seq)-w
		g = 0
		c = 0
		for j = i:i+w
			if     dna_seq[j] == DNA_C c+=1 
			elseif dna_seq[j] == DNA_G g+=1 
			end
		end
		println("$chrome\t$i\t",(g-c)/(g+c))
	end

end

"""
chromsome, coordinate, skew file
what does /dev/null do? get rid of output
produces skew coordinates over whole thing 
22 seconds with 100 size window
NOW 
GRAB THIS SHIT FROM MEGHANA'S Code
lets try to improve it!!!!! and compare the time (see screengrab)

"""
