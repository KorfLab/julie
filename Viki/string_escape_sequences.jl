# You cannot have multiple double quotes like so:
# x = "He said, "Hello, world""
# println(x)
# If we use println(x), it will give us an error

# Neither $ or \ come up literally if they're in a string
# We need to use \ so the double quotes don't give a syntax error
y = "He said, \"Hello, world\""
println(y)
# If we do not use the println() function, the formatting does not work and you get the string "He said, \"Hello, world\""

# We can use \n as "Enter" or a new line in a string
z = "This is a \nnew line"
println(z)

poem = "Errors are red, \nSome things are blue, \nI love coding, \nAnd so should you"
println(poem)

# \t inserts empty space, like a tab (it is 8 characters wide)
tabexample = "I will insert a tab right \t <- here."
println(tabexample)

# \\ can be used if you actually need the backslash in the string
backslash = "This is a backslash: \\"
println(backslash)