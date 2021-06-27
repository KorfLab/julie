using Random

gsize = 100
reads = 400
genome = [0 for n in 1:gsize]
for i = 1:reads
	genome[rand(1:gsize)] += 1
end
println(genome)

