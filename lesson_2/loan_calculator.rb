# need loan amount, APR, and loan duration
# calculate monthly interest rate and loan duration in months
# m = p * (j / (1- (1+j)**(-n)))

def prompt(message)
  Kernel.puts("=> #{message}")
end

def valid_number?(num)
  num.empty?() || num.to_f() < 0
end

prompt("Welcome to Loan Calculator!")

loop do # main loop
  prompt("Please enter the loan amount:")

  loan_amnt = ''
  loop do
    loan_amnt = Kernel.gets().chomp()

    if valid_number?(loan_amnt)
      prompt("Invalid number. Please only positive integers without commas.")
    else
      break
    end
  end

  prompt("Please enter the Annual Percentage Rate (APR):")
  prompt("Example: 10 for 10% or 5.5 for 5.5%")

  apr = ''
  loop do
    apr = Kernel.gets().chomp()

    if valid_number?(apr)
      prompt("Invalid number. Please only positive integers without commas.")
    else
      break
    end
  end

  apr_mn = (apr.to_f / 12) / 100

  prompt("Please enter the loan duration: (In years)")

  loan_dur_yr = ''
  loop do
    loan_dur_yr = Kernel.gets().chomp()

    if loan_dur_yr.empty?() || loan_dur_yr.to_i() < 0
      prompt("Invalid number. Please only positive integers without commas.")
    else
      break
    end
  end

  loan_dur_mn = loan_dur_yr.to_i * 12

  loan_month = loan_amnt.to_f() * (apr_mn.to_f() / (1 - (1 + apr_mn.to_f)**-loan_dur_mn.to_f))

  prompt("Your monthly payments are $#{loan_month.round(2)}.")

  prompt("Would you like to run another calculation? Type y/n")
  answer = Kernel.gets().chomp()
  break unless answer.downcase().start_with?('y')
end

prompt("Thank you for using the Loan Calculator! Goodbye.")
