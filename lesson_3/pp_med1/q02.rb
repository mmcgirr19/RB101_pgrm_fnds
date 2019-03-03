# puts "the value of 40 + 2 is " + (40 + 2)

# Error is you are trying to concatenate a string with an integer.
# Two ways to fix it:

# 1. Turn the integer output into a string

puts "the value of 40 + 2 is " + (40 + 2).to_s

# 2. Use string interpolation

puts "the value of 40 + 2 is #{40 + 2}"