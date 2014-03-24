require './lib/board'

class Ai

  def initialize(board)
    @board = board
    @ai_sign = -1
  end

  def ai_make_move(value)
    until @board.sample == 0
    end
    random_move =
    @board.fill_cell(value, @ai_sign)
  end

  def random_move
    @board
  end

end
