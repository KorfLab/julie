using BioSequences
function orf()
    jay = 0
    genome = randdnaseq(500)
    orfs = Dict()
    for i = 1:498
        codon = translate(genome[i:i+2])
        if codon == aa"M"
            for j = i:3:498
                codon = translate(genome[j:j+2])
                if codon == aa"*"
                    jay = j
                    break
                end 
            end 
            length_ = jay - i 
            if haskey(orfs, length_)
                orfs[length_]+= 1
            else 
                orfs[length_] =1 
            end
        end 
    end 
    println(orfs)
end
orf() 
""" 
Variables in loops aren't global --> created "jay" to track "j"
Want to look for other BioSequences functions to improve this program
"""
