class Menu

  WELCOME = "\nWelcome to Tic Tac Toe!"

  attr_accessor :size


  def initialize(io)
    @io = io
  end

  def get_options
    @io.output_message WELCOME
    board_size
  end

  def board_size
    board_size_message = "\nWhat board size would you like?\nPlease enter the base dimension. (3 for 3 by 3; 4 for 4 by 4): "
    self.size = (@io.player_input board_size_message).to_i
  end

  def player_name(i)
    player_name = "Enter NAME for Player "
    name = (@io.player_input player_name + "#{i}: ").capitalize
  end

  def player_token(i)
    player_token = "Enter TOKEN for Player "
    token = (@io.player_input player_token + "#{i}: ")[0].capitalize
  end

  def player_type(i)
    player_type = "Enter TYPE for Player "
    human_or_ai = " (human or ai): "
    type = @io.player_input player_type + "#{i}" + human_or_ai
  end

end
