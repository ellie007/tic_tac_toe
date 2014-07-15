class EasyAi

  def find_move(max_token, min_token, num_of_players, board)
    available_cells = []
    board.cells.each_with_index do |value, index|
      available_cells << index if value.nil?
    end
    available_cells.sample
  end

end
