class EasyAi

  def initialize(board)
    @board = board
  end

  def find_move(_max_token, _min_token, _num_of_players)
    available_cells = []
    @board.cells.each_with_index do |value, index|
      available_cells << index if value.nil?
    end
    available_cells.sample
  end 

end
