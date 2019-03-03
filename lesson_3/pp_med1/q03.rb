# def factors(number)
#   divisor = number
#   factors = []
#   begin
#     factors << number / divisor if number % divisor == 0
#     divisor -= 1
#   end until divisor == 0
#   factors
# end



def factors(number)
  divisor = number
  factors = []

  loop do
    if divisor > 0
      factors << number / divisor if number % divisor == 0
      divisor -= 1
    else
      puts "Input number has no factors"
    end
    break if divisor <= 0
  end
  factors
end

puts factors(5)
puts factors(0)
puts factors(10)
puts factors(-2)

# Bonus 1: purpose of number % divisor == 0 is to determine if the division
# results in a whole number integer (has no remainder)

# Bonus 2: the purpose of the factors line is to output the factors array