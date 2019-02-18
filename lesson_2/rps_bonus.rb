VALID_CHOICES = %w(rock paper scissors lizard Spock)

def prompt(message)
  Kernel.puts("=> #{message}")
end

choice_prompt = <<-MSG
Please type:
r for rock
s for scissors
p for paper
l for lizard
sp for Spock
MSG

def win?(first, second)
  ((first == 'rock' || first == 'Spock') && second == 'scissors') ||
    ((first == 'paper' || first == 'Spock') && second == 'rock') ||
    ((first == 'scissors' || first == 'lizard') && second == 'paper') ||
    ((first == 'paper' || first == 'lizard') && second == 'Spock') ||
    ((first == 'scissors' || first == 'rock') && second == 'lizard')
end

def display_results(player, computer)
  if win?(player, computer)
    prompt("You Won!")
  elsif win?(computer, player)
    prompt("Computer won!")
  else
    prompt("It's a tie!")
  end
end

# Sum of points total to win match and be grand winner
grand_total = 5

loop do
  player_total = 0
  computer_total = 0
  loop do
    choice = ''
    loop do
      prompt("Choose one: #{VALID_CHOICES.join(', ')}")
      prompt(choice_prompt)
      user_choice = Kernel.gets().chomp()

      choice = case user_choice
               when 'r'
                 'rock'
               when 's'
                 'scissors'
               when 'p'
                 'paper'
               when 'l'
                 'lizard'
               when 'sp'
                 'Spock'
               end

      if VALID_CHOICES.include?(choice)
        break
      else
        prompt("That's not a valid choice.")
      end
    end

    computer_choice = VALID_CHOICES.sample

    prompt("You chose: #{choice}; Computer chose: #{computer_choice}")

    display_results(choice, computer_choice)
    if win?(choice, computer_choice)
      player_total += 1
    elsif win?(computer_choice, choice)
      computer_total += 1
    else
      puts "No Score."
    end
    puts "Your score: #{player_total}. Computer's score: #{computer_total}."
    break if player_total == tgrand_total || computer_total == grand_total
  end

  if player_total == grand_total
    puts "You are the Grand Winner!"
  else
    puts "You lose. Match over."
  end

  prompt("Do you want to play again?")
  answer = Kernel.gets().chomp()
  break unless answer.downcase().start_with?('y')
end

prompt("Thank you for playing. Goodbye!")
