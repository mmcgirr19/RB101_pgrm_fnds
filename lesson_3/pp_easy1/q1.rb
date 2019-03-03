numbers = [1, 2, 2, 3]
numbers.uniq

puts numbers

# output: 1
# 2
# 2
# 3
# uniq, according to Ruby docs, returns a new array by removing duplicate values
# in self. The output, however, will not change the numbers array.