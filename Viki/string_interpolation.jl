# Use $() syntax for string interpolation
# Put $() in a literal string
# If you have "zxywvut" and want to interpolate "Help!" in place of w, you could use "zxy$("Help!")wvut"
# The argument inside $() must be a string value or something that can be formatted as a string

# This works very similar to Python f-strings to mix variables and strings
my_name = "Viki" 
ex1 = "My name is $(my_name)"
println(ex1)

# Multiple assignment with string interpolation
name1, name2 = "Joey", "Elliot"
ex2 = "$(name1) and $(name2) are friends" 
println(ex2)

# To use a literal $ you need \
ex3 = "I have \$3"
println(ex3)