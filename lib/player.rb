require './lib/board'

class Player

  def initialize(board)
    @board = board
    @player_sign = -1
  end

  def player_make_move(value)
    @board.fill_cell(value, @player_sign)
  end

end

