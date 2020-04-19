# CONSTANTS

SUITS = %w(H D S C)
VALUES = %w(2 3 4 5 6 7 8 9 10 J Q K A)

# Methods
def prompt(msg)
  puts "~ #{msg}"
end

def shuffle_deck
  SUITS.product(VALUES).shuffle
end

def total(cards)
  # cards = [['D', '4'], ['S', 'K'],...]
  values = cards.map { |card| card[1] }

  sum = 0
  values.each do |value|
    if value == "A"
      sum += 11
    elsif value.to_i == 0 # K, Q, J
      sum += 10
    else
      sum += value.to_i
    end
  end

  # Aces adjustment - would it run the risk of subtracting 2 aces down to 2 instead of 1
  values.select { |value| value == "A" }.count.times do
    sum -= 10 if sum > 21
  end

  sum
end

def bust?(cards)
  total(cards) > 21
end

# determine winner of round
def find_result(dealer_cards, player_cards)
  player_total = total(player_cards)
  dealer_total = total(dealer_cards)

  if player_total > 21
    :player_bust
  elsif dealer_total > 21
    :dealer_bust
  elsif dealer_total < player_total
    :player
  elsif dealer_total > player_total
    :dealer
  else
    :tie
  end
end

def display_result(dealer_cards, player_cards)
  result = find_result(dealer_cards, player_cards)

  case result
  when :player_bust
    prompt "You busted! Dealer wins!"
  when :dealer_bust
    prompt "Dealer busted! You win!"
  when :player
    prompt "You win!"
  when :dealer
    prompt "Dealer wins!"
  when :tie
    prompt "It's a tie!"
  end
end

def play_again?
  puts "-------------"
  prompt "Would you like to play again? (Yes or No)"
  answer = gets.chomp
  answer.downcase.start_with?('y')
end

# Main Code

loop do
  prompt "Welcome to Virtual Blackjack!"

  # initialze variables
  deck = shuffle_deck
  player_cards = []
  dealer_cards = []

  # initial deal
  2.times do
    player_cards << deck.pop # explain: taking the "popped" number and pushing it into the array; 2 times for 2 cards
    dealer_cards << deck.pop
  end

  prompt "Dealer has #{dealer_cards[0]} and an unknown card"
  prompt "You have: #{player_cards[0]} and #{player_cards[1]}, for total of #{total(player_cards)}."

  # player turn
  loop do
    player_turn = nil
    loop do
      prompt "Would you like to HIT or STAY? Type H or S."
      player_turn = gets.chomp.downcase
      break if ['h', 's'].include?(player_turn)
      prompt "Sorry, must enter 'h' or 's'."
    end

    if player_turn == 'h'
      player_cards << deck.pop
      prompt "Hit!"
      prompt "Your cards are now: #{player_cards}"
      prompt "Your total is now: #{total(player_cards)}"
    end

    break if player_turn == 's' || bust?(player_cards)
  end

  if bust?(player_cards)
    display_result(dealer_cards, player_cards)
    play_again? ? next : break
  else
    prompt "You stayed at #{total(player_cards)}"
  end

  # dealer turn
  prompt "Dealer's turn."

  loop do
    break if total(dealer_cards) >= 17

    prompt "Dealer hits!"
    dealer_cards << deck.pop
    prompt "Dealer's cards are now: #{dealer_cards}"
  end

  if bust?(dealer_cards)
    prompt "Dealer tool is now: #{total(dealer_cards)}"
    display_result(dealer_cards, player_cards)
    play_again? ? next : break
  else
    prompt "Dealer stays at #{total(dealer_cards)}"
  end

  # both player and dealer stays

  puts "------------------"
  prompt "Dealer has #{dealer_cards}, for a total of: #{total(dealer_cards)}"
  prompt "Player has #{player_cards}, for a total of: #{total(player_cards)}"
  puts "------------------"

  display_result(dealer_cards, player_cards)

  break unless play_again?
end

prompt "Thanks you for playing Twenty-One! Goodbye!"
