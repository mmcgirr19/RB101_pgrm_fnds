# Lesson 6.6 Rubocop Tic Tac Toe

# CONSTANTS
require 'pry'

WINNING_LINES =   [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
                  [[1, 5, 9], [3, 5, 7]]

INITIAL_MARKER = ' '
HUMAN_MARKER = 'X'
COMPUTER_MARKER = 'O'
VALID_ANSWERS = %w(1 2 y Y yes Yes YES n N no No NO)
ROUNDS = 5
MAIN_SQUARE = 5
FIRST_MOVE = 'choose' # options ('choose', 'human', 'computer')

# Methods

def prompt(msg)
  puts "=> #{msg}"
end

def welcome_message
  prompt "Welcome to Tic Tac Toe!"
  prompt "The first player to win #{ROUNDS} rounds is the ultimate champion!"
end

def display_board_key
  puts ""
  puts "Board Key"
  puts " 1 | 2 | 3"
  puts "---+---+---      You're an #{HUMAN_MARKER}"
  puts " 4 | 5 | 6       Computer is an #{COMPUTER_MARKER}"
  puts "---+---+---"
  puts " 7 | 8 | 9"
  puts ""
end

def display_board(brd)
  puts ""
  puts "     |     |"
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
  puts "     |     |"
  puts ""
end

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def joinor_choice(arr, comma=', ', word='or')
  case arr.size
  when 0 then ''
  when 1 then arr.first
  when 2 then arr.join(" #{word} ")
  else
    arr[-1] = "#{word} #{arr.last}"
    arr.join(comma)
  end
end

def first_player
  if FIRST_MOVE == 'choose'
    assign_first_player
  else
    FIRST_MOVE
  end
end

def select_first_player
  decision = ''
  loop do
    prompt "Please select who will go first: '1' for you or '2' for the computer."
    decision = gets.chomp
    break if VALID_ANSWERS.include?(decision)
    prompt "Invalid answer. Please type '1' or '2'."
  end
  decision
end

def assign_first_player
  select_first_player == '1' ? 'human' : 'computer'
end

def place_piece!(brd, current_player)
  current_player == 'human' ? human_places_piece!(brd) : computer_places_piece!(brd)
end

def human_places_piece!(brd)
  square = ''
  loop do
    prompt "Pick an open square (#{joinor_choice(empty_squares(brd))}):"
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square) && valid_integer?(square.to_s)
    prompt "Sorry that is not a valid choice."
  end
  brd[square] = HUMAN_MARKER
end

def valid_integer?(num)
  num.to_i.to_s == num
end

def computer_places_piece!(brd)
  square = computer_offense(brd, COMPUTER_MARKER)
  square = computer_offense(brd, HUMAN_MARKER) if !square
  square = MAIN_SQUARE if !square && brd[MAIN_SQUARE] == INITIAL_MARKER
  square = empty_squares(brd).sample if !square
  
  brd[square] = COMPUTER_MARKER
end

def computer_offense(brd, marker)
  square = nil
  WINNING_LINES.each do |line|
    square = find_square_threat(line, brd, marker)
    break if square
  end
  square
end

def find_square_threat(line, brd, marker)
  if brd.values_at(*line).count(marker) == 2
    brd.select{|k,v| line.include?(k) && v == INITIAL_MARKER}.keys.first
  end
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def someone_won?(brd)
  !!detect_winner(brd)
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(HUMAN_MARKER) == 3
      return 'Human'
    elsif brd.values_at(*line).count(COMPUTER_MARKER) == 3
      return 'Computer'
    end
  end
  nil
end

def alternate_player(player)
  player == 'human' ? 'computer' : 'human'
end

def score_keep!(score, winner)
  if winner == 'Human'
     score[:human_score] += 1
  elsif winner == 'Computer'
    score[:computer_score] += 1
  else
    nil
  end
  score
end

def rounds_complete?(score)
  score[:human_score] == ROUNDS || score[:computer_score] == ROUNDS
end

def display_match_winner(score)
  if score[:human_score] == ROUNDS
    prompt "You are the grand champion!"
  else score[:computer_score] == ROUNDS
    prompt "The computer is the grand champion. You lose!"
  end
end


# Main Code

loop do
  welcome_message
  score = {human_score: 0, computer_score: 0}
  decision = ''
  current_player = first_player

  loop do
    brd = initialize_board
    loop do
      display_board_key
      display_board(brd)
      place_piece!(brd, current_player)
      current_player = alternate_player(current_player)
      break if someone_won?(brd) || board_full?(brd)
    end

    if someone_won?(brd)
      prompt "#{detect_winner(brd)} won!"
      score_keep!(score, detect_winner(brd))
    else
      prompt "It's a tie!"
    end

    prompt "The score is Human: #{score[:human_score]}, Computer: #{score[:computer_score]}."

    system('clear') || system('cls')

    if rounds_complete?(score)
      display_match_winner(score)
      break
    end
  end

  prompt "Play again? (y or n)"
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
  prompt "Invalid answer. Please type y or n."
end

prompt "Thanks for playing Tic Tac Toe!"














# Main Code

# loop do
#   round = 0
#   human_score = 0
#   computer_score = 0
  
#   loop do
#     current_player = round_first_player

#     board = initialize_board

#     loop do
#       display_board(board)
#       human_places_piece!(board)
#       break if someone_won?(board) || board_full?(board)
#       computer_places_piece!(board)
#       break if someone_won?(board) || board_full?(board)
#     end

#     display_board(board)

#     if someone_won?(board)
#       prompt "#{detect_winner(board)} won!"
#     else
#       prompt "It's a tie!"
#     end

#     loop do
      
#       round += 1
#       if detect_winner(board) == 'Player'
#          human_score += 1
#          break if human_score == 5
#       elsif detect_winner(board) == 'Computer'
#         computer_score += 1
#         break if computer_score == 5
#       else
#         nil
#       end

#       puts "After Round #{round}, the score is Player: #{human_score} and Computer: #{computer_score}"
#       break
#     end
#     break if human_score == 5 || computer_score == 5
#   end

#     if human_score == 5
#     puts "You are the ultimate winner!"
#     elsif computer_score == 5
#       puts "You are the ultimate loser :("
#     else
#       nil
#     end

#   prompt "Play again? (y or n)"
#   answer = gets.chomp
#   break unless answer.downcase.start_with?('y')
#   prompt "Invalid answer. Please type y or n."
# end

# prompt "Thanks for playing Tic Tac Toe!"