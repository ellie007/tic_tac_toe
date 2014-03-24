puts "Welcome to Tic Tac Toe!"


class GameRunner

  def initialize(board)
    @board = board
    @turn_flag = player
  end

  def

    value = gets.chomp
    @board.fill_cell(value)
  end

end
