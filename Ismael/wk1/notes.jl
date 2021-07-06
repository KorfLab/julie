# "=" is an assignment operator
# use to create a variable

mystringexample1 = "a new value"

# double quotes "" are used for a string
# single quotes '' are used for character values
# variable names must start with a letter, but may be continued with a digit
# variable name, operator, valid string

a = 'a'
a = 'b'

# the comma indicates multiple assignment
# 2 variables here are assigned to 2 characters

mystringexample1 = "string, if you want it"
Hello, world = mystringexample1
println(Hello)
println(world)

# a function is indicated by round brackets func()
# println doesn't need any input, but will print a blank line
# the same is not true for other functions like include()

println()

# delimiters are () "" ,
# operators don't need parentheses, these are symbols like = + <

# string literals in julia
# operators * ^ + - and unicode characters

# concatenate strings with *
println("Julia" * " programming")
println("Hello" * ", " * "world")

# can also concatenate using characters
println("Hello" * ',' * ' ' * "world")

# ^ is the repeat operator
println("my"^3)

# ; is used to suppress output
x, y, z = "waw", "wuw", "wow";
println(x*y*z)
println((y*z)^3)

# can get non-standard letters using julia code
# use this to get the symbol for alpha
# these codes can also be tab completed
# if you run this as code you get an error
# println(\alpha)
# type \alpha then press tab to get the character alpha
# can add number to unicode characters to get another unicode character

# string escape sequences in julia
# \", \n, \t, \\
# $ and \ are not interpreted literally if they are in a string

# the backslashes are included in the string
# formatting only occurs when printed
x = "He said \"Hello, world\""; println(x)
# \n insterts new lines, \t inserts tabs
c = "Hello, \nworld"; println(c)
t = "12345678901234567890\nI \twait"; println(t)
# another \ escapes the \
backslasheg = "1 backslash 4 is 1\\4"; println(backslasheg)

# string interpolation in julia
# use $()
# can be used to edit a string literal
println("zxywvut")
println("zxy$("Help!")wvut")
trackedvariable = "one"; println("the value of trackedvariable is $(trackedvariable)")
# the parentheses can be removed if there is no ambiguity
trackedvariable = "two"; println("the value of trackedvariable is $trackedvariable")

trackedvariable, n = "three", 'n'
println("the value of trackedvariable is $(trackedvariable * n)")

println("That'll be \$99999, please")











































