class Player
  def initialize(symbol)
    @symbol = symbol
  end

  attr_reader :symbol

  def move()
    puts "Spot: "
    spot = gets.chomp.to_i
    spot
  end
end

class Board
  WIN = [[1,2,3],[4,5,6],[7,8,9],[1,5,9],[3,5,7],[1,4,7],[2,5,8],[3,6,9]]
  def initialize()
    @board = Array.new(10)
  end

  def free_spots()
    (1..9).select {|spot| @board[spot].nil?}
  end

  def add_player_selection(spot, symbol)
    @board.insert(spot, symbol)
    @board.delete_at(spot+1)
  end

  def check_if_won(symbol)
    WIN.any? do |line|
      line.all? {|spot| @board[spot] == symbol}
    end
  end

  def board_full()
    !@board.any?(nil)
  end
end

# Get player's symbols
puts "Player 1's symbol: "
p1 = Player.new(gets.chomp)
puts "Player 2's symbol"
p2 = Player.new(gets.chomp)
puts "Player 1 is #{p1.symbol} and Player 2 is #{p2.symbol}"

# Create board
board = Board.new()

winning_player = nil
won = false
while won == false
  puts board.free_spots.inspect
  puts "Player 1's move"
  move1 = p1.move
  board.add_player_selection(move1, p1.symbol)
  if board.board_full then puts "It's a draw" end
  won = board.check_if_won(p1.symbol)
  if won == false
    puts board.free_spots.inspect
    puts "Player 2's move"
    move2 = p2.move 
    board.add_player_selection(move2, p2.symbol)
    if board.board_full then puts "It's a draw" end
    won = board.check_if_won(p2.symbol)
    if won == true then winning_player = p2.symbol end
  else
    winning_player = p1.symbol
  end
end

puts "Player #{winning_player} has won!"

# Check full board 
# Show board ongoing 
# Refactor to play 