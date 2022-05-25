# Define your WIN_COMBINATIONS constant

WIN_COMBINATIONS = [
  [0,1,2], #top_row
  [3,4,5], #middle row
  [6,7,8], #bottom_row
  [0,3,6], #first_col
  [1,4,7], #second_col
  [2,5,8], #third_col
  [0,4,8], #diagon
  [6,4,2] #diagon
]

# Helper Methods
def display_board(board)
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts "-----------"
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts "-----------"
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
  end

  def input_to_index(user_input)
    user_input.to_i - 1
  end


def move(board, index, current_player)
    board[index] = current_player
  end
  
  def position_taken?(board, location)
    board[location] != " " && board[location] != ""
  end
  
  def valid_move?(board, index)
    index.between?(0,8) && !position_taken?(board, index)
  end
  
  def turn(board)
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    if valid_move?(board, index)
      move(board, index, current_player(board))
      display_board(board)
    else
      turn(board)
    end
  end
  
  def play(board)
    turn(board) until over?(board)
    if won?(board)
        puts "Congratulations #{winner(board)}!"
    elsif draw?(board)
      puts "Cat's Game!"
    end
end

  def won?(board)
    WIN_COMBINATIONS.detect do |combo|
      board[combo[0]] == board[combo[1]] && 
      board[combo[1]] == board[combo[2]] &&
      position_taken?(board, combo[0])
    end
  end
  
  def full?(board)
    board.all? {|token| token == "X" || token == "O"}
  end
  
  def draw?(board)
    full?(board) && !won?(board)
  end 
  
  def over?(board)
    won?(board) || full?(board) || draw?(board)
  end
  
  def winner(board)
    if winning = won?(board)
      board[winning.first]
    end
  end

  def turn_count(board)
    count = 0
    board.each do |checker|
        if checker == "X" || checker == "O"  
            count += 1
        end
    end
    count
end

def current_player(board)
    turn_count(board).even? ? "X" : "O"
end