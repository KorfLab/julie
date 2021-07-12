seq1 = "AGGTC"
seq2 = "AGGGTC"

match = 1
mismatch = -1
gap = -1


function solvenw(seq_1, seq_2, match, mismatch, gap)
	#Info
	if length(seq_2) >= length(seq_1)
		seq1=seq_1
		seq2=seq_2
	else
		seq1=seq_2
		seq2=seq_1
	end
	
	
	println("""seq1: $(seq1)
		seq2: $(seq2)
		""")

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
	x = seq1_length+1
	y = seq2_length+1
	
	traceback = []
	
	while x!=1
		trace_gap = workspace[x,y] - gap
		if seq1[x-1] == seq2[y-1]
			match_mismatch = match
		else
			match_mismatch = mismatch
		end

		trace_diagnal = workspace[x,y] - match_mismatch
		if trace_diagnal == workspace[x-1,y-1]
			push!(traceback, "matmch/mismatch")
			x = x-1
			y = y-1
		elseif trace_gap == workspace[x,y-1]
			push!(traceback,"left_gap")
			y = y-1
		elseif trace_gap == workspace[x-1,y]
			push!(traceback,"top_gap")
			x = x-1
		end
	end
	
	println(traceback)
	

	
end


solvenw(seq1, seq2, match, mismatch, gap)





