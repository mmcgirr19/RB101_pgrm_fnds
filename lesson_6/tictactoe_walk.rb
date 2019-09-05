# Lesson 6.5 Walk-Through Tic Tac Toe

require 'pry'

INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'

def prompt(msg)
  puts "=> #{msg}"
end

def display_board(brd)
  system 'clear'
  puts "You're a #{PLAYER_MARKER}. Computer is a #{COMPUTER_MARKER}."
  puts ""
  puts "     |     |"
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"  #this allows the method to know where to put X or O
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

#['X', 'O', '', 'X'] #could use an array to tell it how to display board
#no wrong choice on data structure to rep (nested array, array, hash, etc)
# go with hash {1 => 'X', 2=> 'O', 3=> ' '} #we chose to use hash, i.e. 1 is X and 2 is O and 3 empty
#board = {1 => ' ', 2=> ' ', 3=> ' '} board will be all spaces b/c not show anything

def initialize_board # instead of repeatative writing of board hash above b/c have to write all spaces
  new_board = {}
  (1..9).each {|num| new_board[num] = INITIAL_MARKER} #setting value to be a space
  new_board
end

def empty_squares(brd)
  brd.keys.select{|num| brd[num] == INITIAL_MARKER}
end

def player_places_piece!(brd)
  square = ''
  loop do
    prompt "Choose a square (#{empty_squares(brd).join(', ')}):"
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
      prompt "Sorry that is not a valid choice."
  end

  brd[square] = PLAYER_MARKER #using this will work, but if say put 10 a new k-v pair created, just not shown
end

def computer_places_piece!(brd)
  square = empty_squares(brd).sample
  brd[square] = COMPUTER_MARKER
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def someone_won?(brd)
  !!detect_winner(brd)
end

def detect_winner(brd)
  winning_lines = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
                  [[1, 5, 9], [3, 5, 7]]

  winning_lines.each do |line|
    if brd[line[0]] == PLAYER_MARKER &&
       brd[line[1]] == PLAYER_MARKER &&
       brd[line[2]] == PLAYER_MARKER
       return 'Player'
     elsif brd[line[0]] == COMPUTER_MARKER &&
       brd[line[1]] == COMPUTER_MARKER &&
       brd[line[2]] == COMPUTER_MARKER
       return 'Computer'
     end
   end
   nil
end

loop do
  board = initialize_board

  loop do
    display_board(board)
    player_places_piece!(board)
    break if someone_won?(board) || board_full?(board)
    computer_places_piece!(board)
    break if someone_won?(board) || board_full?(board)
  end

  display_board(board)

  if someone_won?(board)
    prompt "#{detect_winner(board)} won!"
  else
    prompt "It's a tie!"
  end

  prompt "Play again? (y or n)"
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt "Thanks for playing Tic Tac Toe!"


