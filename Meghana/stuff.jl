function aa_comp(aa)
    amino_acids = Dict('W'=>0,'C'=>0,'H'=>0,'M'=>0,'Y'=>0,'Q'=>0,'F'=>0,'N'=>0,'P'=>0,'T'=>0,'R'=>0,'I'=>0,'D'=>0,'G'=>0,'A'=>0,'K'=>0,'E'=>0,'L'=>0,'S'=>0, 'V'=>0)
    total = 0
    for letter in aa
        if haskey(amino_acids, letter) 
            amino_acids[letter] += 1
            total += 1
        end
    end
    println(total)
    amino_acids = [(k,v) = (k,v/total) for (k,v) in amino_acids]
    answer = sort([(k,v) = (v,k) for (k,v) in amino_acids])
    return answer
end
aa_comp("MVGGKKKTKICDKVSHEEDRISQLPEPLISEILFHLSTKDSVRTSALSTKWRYLWQSVPG
LDLDPYASSNTNTIVSFVESFFDSHRDSWIRKLRLDLGYHHDKYDLMSWIDAATTRRIQH
LDVHCFHDNKIPLSIYTCTTLVHLRLRWAVLTNPEFVSLPCLKIMHFENVSYPNETTLQK
LISGSPVLEELILFSTMYPKGNVLQLRSDTLKRLDINEFIDVVIYAPLLQCLRAKMYSTK
NFQIISSGFPAKLDIDFVNTGGRYQKKKVIEDILIDISRVRDLVISSNTWKEFFLYSKSR
PLLQFRYISHLNARFYISDLEMLPTLLESCPKLESLILVMSSFNPS")

function aa_pairs()
    aa_string = "WCHMYQFNPTRIDGAKEVLS"
    aa = sort(split(aa_string,""))
    pairs = String[]
    for x = 1:length(aa)-1
        for i = x:length(aa)-1
            push!(pairs, aa[x]*aa[i+1])
        end 
    end
    return pairs
end
aa_pairs()

function anti(DNA)
    anti = ""
    if length(DNA) == 0
        return nothing
    end
    complement = Dict([('A','T'),('T','A'),('C','G'),('G','C')])
    for i = 0:length(DNA)-1
        bp = complement[DNA[length(DNA)-i]]
        anti = anti*bp
    end
    return anti
end
anti("ACTGAAAAAAAAAAA")

using Random
function at_seq()
    sequence = ""
    bp = ['A','A','T','T','C','G']
    at = 0
    for i = 1:30
        next_ = rand(bp)
        sequence = sequence*next_
        if next_ == 'A'||next_ == 'T'
            at+=1
        end
    end
    at_fraction = at/30
    length_ = length(sequence)
    return at_fraction, length_, sequence
end
at_seq()

function birthday(people)
    days = Dict([ ("January", 1:31),
    ("February", 1:28),
    ("March", 1:31),
    ("April", 1:30),
    ("May", 1:31),
    ("June", 1:30),
    ("July", 1:31),
    ("August", 1:31),
    ("September", 1:30),
    ("October", 1:31),
    ("November", 1:30),
    ("December", 1:31)
    ])
    repeat = 0
    for x = 1:100
        birthdays = []
        for i = 1:people
        month = rand(days)[1]
        day = rand(days[month])
            push!(birthdays,(month,day))
        end 
        if length(Set(birthdays)) != length(birthdays)
            repeat += 1
        end
    end
    return repeat/100
end
birthday(70)

function codons(ORF)
    codons_ = []
    i = 1
    while i < length(ORF) - 1
        push!(codons_, ORF[i:i+2])
        i += 3
        println(i)
    end
    return codons_
end
codons("ATAGCGAATATCTCTCATGAGAGGGAA")


function entropy(array_)
    array_ = [(x*log2(x)) for x in array_]
    sum_ = -1*sum(array_)
    return sum_
end
entropy([.1 .2 .3 .4])


function frame(DNA)
    for i = 1:length(DNA)
        x = string(i)
        y = string(i%3)
        println(x*" "*y*" "*DNA[i])
    end
end
frame("ATGGCCTTT")

function gc(DNA, x)
    count = 0
    for i = 1:length(DNA)
        if DNA[i]=='G'||DNA[i]=='C'
            count += 1
        end
    end
    percent = count/length(DNA)
    return round(percent, digits = x)
end 
gc("ACAGAGCCAGCAGATATACAGCAGATACTAT", 2)

function gc_win(DNA, L)
    for i = 1: length(DNA)-(L-1)
        println(string(i)*" "*string(gc(DNA[i:i+L-1],4))*" "*DNA[i:i+L-1])
    end
end
gc_win("ACGACGCAGGAGGAGAGTTTCAGAGATCACGAATACATCCATATTACCCAGAGAGAG", 11)

function gc_win2(seq, L)
    out_ = Matrix{Union{Float64, String, Nothing}}(nothing, length(seq)-(L-1), 3)
    for i = 1:length(seq)-(L-1)
        out_[i, 1] = Float64(i)
        out_[i, 2] = seq[i:i+L-1]
        out_[i, 3] = gc(seq[i:i+L-1], 4)
    end
    return out_
end
gc_win2("ACGACGCAGGAGGAGAGTTTCAGAGATCACGAATACATCCATATTACCCAGAGAGAG", 11)

# no n50 
using Statistics
function seqstats(file)
    file = open(file, "r")
    sequences = readlines(file)
    num_seq = 0
    length_ = 0
    seq_len = []
    for line in sequences
        if line[1] != ">"
            num_seq+=1
            length_ += length(line)
            push!(seq_len, length(line))
        end 
    end 
    min = sort(seq_len)[1]
    max = sort(seq_len)[length(seq_len)]
    avg = mean(seq_len)
    med = median(seq_len)
    return num_seq, length_, min, max, avg, med
end


print("hi")
