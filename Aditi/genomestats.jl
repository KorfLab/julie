#julia uses "using" instead of "import
using ArgParse
#FASTX contains programs to unpack and read fasta/fastq files
using FASTX

using BioSequences
using CodecZlib

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

function unpacker(file)
    if splitext(file)[2]==".gz"
        myfasta=FASTA.Reader(GzipDecompressorStream(open(file)))
   else myfasta=FASTA.Reader(open(file))
   end
   return myfasta
end

function dnastring(myfasta)
    
    mydict=Dict{DNA, String}(
        DNA_A => "A", 
        DNA_T => "T", 
        DNA_C => "C", 
        DNA_G => "G",
    )
    all_seqs=String[]
    for pair in myfasta
        dna_seq=FASTA.sequence(pair)
        chars=String[]

        for i in 1:length(dna_seq)
            if haskey(mydict, dna_seq[i])
                nt = mydict[dna_seq[i]]
            else
                nt = "N"
            end
            push!(chars, nt)
        end
        string_seq=join(chars)
        push!(all_seqs, string_seq)
    end
    return all_seqs
end


#get fasta tupes
myfasta=unpacker(arg["file"])

#get string sequences
mydata=dnastring(myfasta)

#I do not know why this is necessary but it is :(
function tester(myfasta)
    contigs = 0
    contig_lengths = []
    nt_length = 0
    nt_counts = Dict()

    for seq in mydata
        len = length(seq)
        contigs +=1
        #appending to contig_lengths
        push!(contig_lengths, len)
        nt_length += len
        for i in 1:len
            n = seq[i]
            holder=get!(nt_counts, n, 0)
            holder+=1
            nt_counts[n] = holder
        end
    end
    println(contigs)
    println("--------")
    println(contig_lengths)
    println("--------")
    println(nt_length)
    println("--------")
    println(keys(nt_counts))
    println("--------")
    println(values(nt_counts))
end

tester(myfasta)



    