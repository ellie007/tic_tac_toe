class Menu

  def initialize(io)
    @io = io
  end

  def get_board_size
    @io.output(board_size_prompt)
    @board_size = @io.input.to_i
    if @board_size != 3 && @board_size != 4
      get_board_size
    else
      return @board_size
    end
  end

  def get_board_dimension
    @io.output(dimension_type_prompt)
    @board_dimension = @io.input.to_i
    if @board_dimension != 2 && @board_dimension != 3
      get_board_dimension
    else
      return @board_dimension
    end
  end

  def get_number_of_players
    @io.output(num_of_players_prompt)
    @num_of_players = @io.input.to_i
    if @num_of_players == 0
      get_number_of_players
    else
      return @num_of_players
    end
  end

private

  def board_size_prompt
    "What board size would you like?\nPlease enter the base dimension. (3 for 3 by 3; 4 for 4 by 4): "
  end

  def dimension_type_prompt
    "What dimension type do you want for your board? (2 for 2D: 3 for 3D): "
  end

  def num_of_players_prompt
    "How many players would you like for the game?: "
  end

end




