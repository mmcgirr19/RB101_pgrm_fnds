answer = 42

def mess_with_it(some_number)
  some_number += 8
end

new_answer = mess_with_it(answer)

p answer - 8

# output = 34
# the variable answer has not changed from the original object; therefore it's 42 - 8 = 34