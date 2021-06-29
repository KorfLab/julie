#import displaymatrix function that displays matrix
include("displaymatrix.jl")

#user input
print("Enter your first sequence: ")
seq1 = "AGGTC" #=readline()=#
print("Enter your second sequence: ")
seq2 = "AGGGTC" #=readline()=#

#confirm sequences
println("""your first sequence is $(seq1)
your seceond sequence is $(seq2)""")

#Scores
match = 1
mismatch = -1
gap = -1

println("""
match score = $(match)
mismatch score = $(mismatch)
gap score = $(gap)
""")

#Initializing Matrix 
seq1_length = sizeof(seq1)
seq2_length = sizeof(seq2)

workspace = fill(0,(seq1_length+1,seq2_length+1))

#Initialization
for i in 2:seq1_length+1, j in 2:seq2_length+1
	workspace[i,1] = workspace[i-1,1]+gap
	workspace[1,j] = workspace[1,j-1]+gap
end

displaymatrix(workspace)

