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
    board_size_prompt = "What board size would you like?\nPlease enter the base dimension. (3 for 3 by 3; 4 for 4 by 4): "
    @io.output_message(board_size_prompt)
    @io.input_prompt.to_i
  end

  private

  def get_player_name(i)
    player_name_prompt = "Enter NAME for Player #{i}: "
    @io.output_message(player_name_prompt)
    @io.input_prompt.capitalize
  end

  def get_player_token(i)
    player_token_prompt = "Enter TOKEN for Player #{i}: "
    @io.output_message(player_token_prompt)
    @io.input_prompt[0].capitalize
  end

  def get_player_type(i)
    player_type_prompt = "Enter TYPE for Player #{i} (1 for human : 2 for ai): "
    @io.output_message(player_type_prompt)
    @io.input_prompt.to_i
  end

end
