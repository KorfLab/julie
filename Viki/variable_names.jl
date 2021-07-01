# Variable names have the following requirements:
# Starting with a letter
# Continuing with letters, digits, underscores, or exclamation marks

# In these examples, the Roman alphabet letters are used, but many other letters are accepted
# Best practice is to use lower case letters and digits with descriptive names

# Julia requires that the variable be on the left and the value be on the right

my_name = "My name is Viki"
println(my_name)

my_name1 = "My first name is Viktoria"
println(my_name1)

my_name2 = "My last name is Haghani"
println(my_name2)

vikis_pets = "I have four pets: Stella, Zoscia, Sunny, and Blueberry"
println(vikis_pets)

weird_l00king_var!abl3_name = "weird_l00king_var!abl3_name is a valid variable name in Julia"
println(weird_l00king_var!abl3_name)

# If a comma follows a valid variable name on the left of the assignment operator, the commma indicates that Julia should perform multiple assignment
# This assigns the variable to each character of the string in the order specified
stringexample = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
Hello, world, we, are, going, in, this, order = stringexample
println(Hello)
println(world)
println(we)
println(are)
println(going)
println(in)
println(this)
println(order)
