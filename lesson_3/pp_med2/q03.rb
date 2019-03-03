def tricky_method(a_string_param, an_array_param)
  a_string_param += "rutabaga"
  an_array_param << "rutabaga"
end

my_string = "pumpkins"
my_array = ["pumpkins"]
tricky_method(my_string, my_array)

puts "My string looks like this now: #{my_string}"
puts "My array looks like this now: #{my_array}"

# output: My string looks like this now: pumpkins
# Because the my_string variable was not changed by the method; my_string points to the same object

# =>      My string looks like this now: ["pumpkins", rutabaga"]
# Because the an_array_param is pushing rutabaga to the array and it's a destructive argument
# so my_array is changed