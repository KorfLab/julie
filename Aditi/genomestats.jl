#julia uses "using" instead of "import
using ArgParse
#FASTX contains programs to unpack and read fasta/fastq files
using FASTX

#Julia cli setup

cli=ArgParseSettings()
@add_arg_table! cli begin
    "--file"
        help="path to sequence file"
        required=true
        #arg_type=int or float or whatever the type is
        #default=
    #next flag would go here
end

arg=parse_args(ARGS, cli)


#if statements in Julia require an end at the end of the entire statement
if splitext(arg["file"])[2]==".gz"
     myfasta=FASTA.Reader(GzipDecompressorStream(open(arg["file"])))
else myfasta=FASTA.Reader(open(arg["file"]))
end

println("running")

function tester(myfasta)
    contigs = 0
    contig_lengths = []
    nt_length = 0
    nt_counts = Dict()
    println(contigs, nt_length, contig_lengths, nt_counts)
    for pair in myfasta
        seq=FASTA.sequence(pair)
        #seq = uppercase(seq)
        println(seq)
        len = length(seq)
        println(len)
        println(seq)
        contigs = contigs + 1
        #appending to contig_lengths
        push!(contig_lengths, len)
        nt_length = nt_length + len
        for i in 1:len
            n = seq[i]
            holder=get!(nt_counts, n, 0)
            holder+=1
            nt_counts[n] = holder
        end
    end
    println(contigs)
    println(contig_lengths)
    println(nt_length)
    println(nt_counts)

end

tester(myfasta)



    