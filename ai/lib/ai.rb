require '../board/lib/board'

class Ai

  def initialize(board)
    @board = board
    @ai_sign = -1
  end

  def ai_make_move(value)
    @board.fill_cell(value, @ai_sign)
  end

end
