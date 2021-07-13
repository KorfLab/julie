seq1 = "AGGTCAAG"
seq2 = "AGGGTCAG"

match = 1
mismatch = -1
gap = -1


function solvenw(seq_1, seq_2, match, mismatch, gap)
	#Info
	
	
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
	score = 0 
	while x!=1
		trace_gap = workspace[x,y] - gap
		if seq1[x-1] == seq2[y-1]
			trace_diagnal = workspace[x,y] - match
			local_mm = match
		else
			trace_diagnal = workspace[x,y] - mismatch
			local_mm = mismatch
		end


		if trace_diagnal == workspace[x-1,y-1]
			push!(traceback, "match/mismatch")
			x = x-1
			y = y-1
			score += local_mm
		elseif trace_gap == workspace[x,y-1]
			push!(traceback,"left_gap")
			y = y-1
			score += gap
		elseif trace_gap == workspace[x-1,y]
			push!(traceback,"top_gap")
			x = x-1
			score += gap
		end
	end
	
	println(traceback)

	aligned_seq1 = ""
	aligned_seq2 = ""
	counter_seq1 = 1
	counter_seq2 = 1
	
	for i in length(traceback):-1:1
		if traceback[i] == "match/mismatch"
			aligned_seq1 *= seq1[counter_seq1]
			aligned_seq2 *= seq2[counter_seq2]
			counter_seq1 += 1
			counter_seq2 += 1
		elseif traceback[i] == "left_gap"
			aligned_seq1 *= '-'
			aligned_seq2 *= seq2[counter_seq2]
			counter_seq2 += 1
		elseif traceback[i] == "top_gap"
			aligned_seq2 *= '-'
			aligned_seq1 *= seq1[counter_seq1]
			counter_seq1 +=1
		end
	end
	
	println(aligned_seq1)
	println(aligned_seq2)
	
	#Score
	println("score = $(score)")
	
	
end


solvenw(seq1, seq2, match, mismatch, gap)





