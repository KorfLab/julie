# Make some strings
name1 = "Viki"
name2 = "Noah"
phrase = " is friends with "

# Concatenate strings
first_sentence = name1 * phrase * name2
println(first_sentence)

# Concatenate a different string
second_sentence = name2 * phrase * name1
println(second_sentence)

# Now let's repeat strings
rep1 = "my " * "my " * "my "
println(rep1)
rep2 = "my "^3
println(rep2)

# Use both the * and ^ operator
ops = "my "^3 * "what big teeth you have"
println(ops)

# Concatenate variables
x, y, z = "what's this? ", "what's this? ", "there's magic in the air!"
println(x*y*z)

# We can also repeat multiple strings
println((x*y*z)^3)

# If using command line, use ; to suppress outputs like so
# x, y, z = "string 1", "this is a string", "but this? what's this?";
# x*y*z

# We can also use characters outside of those available on international keyboards
# On the command line, type
# \alpha
# Then click tab
# You can directly use the unicode value by typing the following (single quotes must be included)
# '\u03b1'
# The second method allows for use in scripts
println('\u03b1')

# In Julia, we can add numbers to characters to give us the corresponding letter in the alphabet
# This is based on the unicode, where 'a' is \u0061 and 'b' is \u0062
println('a' + 1)