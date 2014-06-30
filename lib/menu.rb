class Menu

  def initialize(io)
    @io = io
  end

  def get_player_options(i)
    { :name => get_player_name(i),
      :token => get_player_token(i),
      :type => get_player_type(i) }
  end

  def get_board_size
    @io.output(board_size_prompt)
    board_size = @io.input.to_i
    if board_size != 3 && board_size != 4
      get_board_size
    else
      return board_size
    end
  end

  def get_board_dimension
    @io.output(dimension_type_prompt)
    dimension = @io.input.to_i
    if dimension != 2 && dimension != 3
      get_board_dimension
    else
      return dimension
    end
  end

  def get_number_of_players
    @io.output(num_of_players_prompt)
    @io.input.to_i
  end

private

  def get_player_name(i)
    @io.output(player_name_prompt(i))
    @io.input.capitalize
  end

  def get_player_token(i)
    @io.output(player_token_prompt(i))
    player_token = @io.input[0].capitalize
    if !('A'..'Z').include?(player_token)
      get_player_token(i)
    else
      return player_token
    end
  end

  def get_player_type(i)
    @io.output(player_type_prompt(i))
    player_type = @io.input.to_i
    if player_type != 1 && player_type != 2
      get_player_type(i)
    else
      return player_type
    end
  end

  def board_size_prompt
    "What board size would you like?\nPlease enter the base dimension. (3 for 3 by 3; 4 for 4 by 4): "
  end

  def dimension_type_prompt
    "What dimension type do you want for your board (2 for 2D: 3 for 3D): "
  end

  def num_of_players_prompt
    "How many players would you like for the game?: "
  end

  def player_name_prompt(i)
    "Enter NAME for Player #{i}: "
  end

  def player_token_prompt(i)
    "Enter TOKEN for Player #{i} (a to z): "
  end

  def player_type_prompt(i)
    "Enter TYPE for Player #{i} (1 for human : 2 for ai): "
  end

end
