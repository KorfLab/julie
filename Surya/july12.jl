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
