class Menu

  attr_accessor :board_size

  def initialize(io)
    @io = io
  end

  def get_options
    @io.output_message("\nWelcome to Tic Tac Toe!")
    get_board_size
  end

  def get_board_size
    board_size_prompt = "\nWhat board size would you like?\nPlease enter the base dimension. (3 for 3 by 3; 4 for 4 by 4): "
    self.board_size = (@io.prompt_for_input board_size_prompt).to_i
  end

  def get_player_name(i)
    player_name_prompt = "Enter NAME for Player #{i}: "
    (@io.prompt_for_input(player_name_prompt)).capitalize
  end

  def get_player_token(i)
    player_token_prompt = "Enter TOKEN for Player #{i}: "
    (@io.prompt_for_input(player_token_prompt))[0].capitalize
  end

  def get_player_type(i)
    player_type_prompt = "Enter TYPE for Player #{i} (human or ai): "
    @io.prompt_for_input(player_type_prompt)
  end

end
