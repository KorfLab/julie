seq1 = "AGGTC"
seq2 = "AGGGTC"

println("""seq1 is $(seq1)
seq2 is $(seq2)""")

#Scores
match = 1
mismatch = -1
gap = -1

println("""
match score = $(match)
mismatch score = $(mismatch)
gap score = $(gap)
""")

function solvenw(seq1, seq2, match, mismatch, gap)
	#Initializing Matrix 
	seq1_length = sizeof(seq1)
	seq2_length = sizeof(seq2)

	workspace = fill(0,(seq1_length+1,seq2_length+1))

	#Initialization
	for i in 2:seq1_length+1, j in 2:seq2_length+1
		workspace[i,1] = workspace[i-1,1]+gap
		workspace[1,j] = workspace[1,j-1]+gap
	end
	
	#Display
	println("Initializaiton:")
	display(workspace)
	println("")
	
	#Fill
	for i in 2:seq1_length+1
		for j in 2:seq2_length+1
			left_gap = workspace[i,j-1]+gap
			top_gap = workspace[i-1,j]+gap
			if seq1[i-1] == seq2[j-1]
				match_mismatch = workspace[i-1,j-1]+match
			else
				match_mismatch = workspace[i-1,j-1]+mismatch
			end
			workspace[i,j]=max(left_gap,top_gap,match_mismatch)
		end
	end
	
	#Display
	println("Fill:")
	display(workspace)
	println("")
	
	#Trace Back
end


solvenw(seq1, seq2, match, mismatch, gap)





