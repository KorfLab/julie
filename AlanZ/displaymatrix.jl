#function that displays matrix like a matrix
function displaymatrix(matrix)
        println("Your matrix:")
        matrix = matrix
        for i in 1:size(matrix)[1]
             for j in 1:size(matrix)[2]
                print(matrix[i,j]," ")
                end
                println("")
        end
end
#------------------------------------------
