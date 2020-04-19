# CONSTANTS

SUITS = %w(H D S C)
VALUES = %w(2 3 4 5 6 7 8 9 10 J Q K A)
ROUNDS = 5
TOP_VALUE = 21
DEALER_VALUE = 17

# Methods
def prompt(msg)
  puts "~ #{msg}"
end

def clear
  system('clear') || system('cls')
end

def welcome_msg
  prompt "Welcome to Virtual Blackjack!"
  prompt "The rules are simple. Whomever's deck is closest to #{TOP_VALUE} without going over wins."
  prompt "If you go over, you BUST! The dealer also busts if his sum is #{DEALER_VALUE}."
  prompt "The first player to win #{ROUNDS} rounds is the ultimate victor!"
  prompt "Let the games begin."
end

def shuffle_deck
  SUITS.product(VALUES).shuffle
end

def initial_deal(deck, player_cards, dealer_cards)
  2.times do
    player_cards << deck.pop
    dealer_cards << deck.pop
  end
end

def initial_score(player, dealer)
  {
    player: add_total(player),
    dealer: add_total(dealer)
  }
end

def add_total(cards)
  values = cards.map { |card| card[1] }

  sum = 0
  values.each do |value|
    if value == "A"
      sum += 11
    elsif value.to_i == 0
      sum += 10
    else
      sum += value.to_i
    end
  end

  values.select { |value| value == "A" }.count.times do
    sum -= 10 if sum > TOP_VALUE
  end

  sum
end

def player_turn(deck, player_cards, sum)
  loop do
    player_choice = nil
    loop do
      prompt "Would you like to HIT or STAY? Type H or S."
      player_choice = gets.chomp.downcase
      break if ['h', 's'].include?(player_choice)
      prompt "Sorry, must enter 'H' or 'S'."
    end

    if player_choice == 'h'
      player_cards << deck.pop
      sum[:player] = add_total(player_cards)
      prompt "HIT! Your cards are now: #{player_cards}"
      prompt "Your total is: #{sum[:player]}"
    end

    break if player_choice == 's' || bust?(:player, sum)
  end
end

def bust?(which_player, sum)
  sum[which_player] > TOP_VALUE
end

def dealer_turn(deck, dealer_cards, sum)
  prompt "You've chosen to STAY. The dealer will go."
  loop do
    break if sum[:dealer] >= DEALER_VALUE
    prompt "Dealer hits!"
    dealer_cards << deck.pop
    sum[:dealer] = add_total(dealer_cards)
    prompt "Dealer's cards are now: #{dealer_cards}"
  end
  prompt "Dealer's total is #{sum[:dealer]}."
end

# determine winner of round
def find_result(sum)
  if sum[:player] > TOP_VALUE
    :player_bust
  elsif sum[:dealer] > TOP_VALUE
    :dealer_bust
  elsif sum[:dealer] < sum[:player]
    :player
  elsif sum[:dealer] > sum[:player]
    :dealer
  else
    :tie
  end
end

def display_result(result, sum)
  case result
  when :player_bust
    prompt "You busted! Dealer wins!"
  when :dealer_bust
    prompt "Dealer busted! You win!"
  when :player
    prompt "Your score is #{sum[:player]}"
    prompt "You win!"
  when :dealer
    prompt "Your score is #{sum[:player]}"
    prompt "Dealer wins!"
  when :tie
    prompt "Your score is #{sum[:player]}"
    prompt "It's a tie!"
  end
end

def add_round_score(result, round)
  case result
  when :player_bust
    round[:dealer_round] += 1
  when :dealer_bust
    round[:player_round] += 1
  when :dealer
    round[:dealer_round] += 1
  when :player
    round[:player_round] += 1
  end
end

def determine_match_score(score, round)
  result = find_result(score)
  display_result(result, score)
  add_round_score(result, round)
  prompt "You've won #{round[:player_round]} round(s)." \
         " The dealer has won #{round[:dealer_round]} round(s)."
end

def end_match?(round)
  round[:player_round] >= ROUNDS || round[:dealer_round] >= ROUNDS
end

def display_winner(round)
  if round[:player_round] == ROUNDS
    prompt "You did it! You are the ultimate winner!"
  elsif round[:dealer_round] == ROUNDS
    prompt "The Dealer beat you. You have lost it all..."
  end
end

def play_again?
  puts "-------------"
  prompt "Would you like to play again? (Yes or No)"
  answer = gets.chomp
  answer.downcase.start_with?('y')
end

# -------- Main Code ---------

round = {
  player_round: 0,
  dealer_round: 0
}

loop do
  welcome_msg

  loop do
    # initialze variables
    deck = shuffle_deck
    player_cards = []
    dealer_cards = []

    initial_deal(deck, player_cards, dealer_cards)
    totals = initial_score(player_cards, dealer_cards)

    puts "-------------------------------------------"
    prompt "Dealer has #{dealer_cards[0]} and an unknown card"
    prompt "Your hand is #{player_cards[0]} and #{player_cards[1]}."
    prompt "Your total is #{totals[:player]}."

    loop do
      player_turn(deck, player_cards, totals)
      break if bust?(:player, totals)
      clear
      dealer_turn(deck, dealer_cards, totals)
      break
    end

    determine_match_score(totals, round)
    break if end_match?(round)
  end

  display_winner(round)
  play_again? ? next : break
end

prompt "Thanks you for playing Twenty-One! Goodbye!"
