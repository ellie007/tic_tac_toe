class Menu

  WELCOME = "\nWelcome to Tic Tac Toe!"

  BOARD_SIZE = "\nWhat board size would you like?\nPlease enter the base dimension.  (3 for 3 by 3; 4 for 4 by 4): "

  PLAYER_NAME = "Enter NAME for Player "
  PLAYER_TOKEN = "Enter TOKEN for Player "
  PLAYER_TYPE = "Enter TYPE for Player "
  ENDING_COLON = ": "
  HUMAN_OR_AI = " (human or ai)"


  attr_accessor :size

  def initialize(io)
    @io = io
  end

  def get_options
    @io.output_message WELCOME
    board_size
  end

  def board_size
    @size = (@io.player_input BOARD_SIZE).to_i
  end

  def player_name(i)
    name = (@io.player_input PLAYER_NAME + "#{i}" + ENDING_COLON).capitalize
  end

  def player_token(i)
    token = (@io.player_input PLAYER_TOKEN + "#{i}" + ENDING_COLON)[0].capitalize
  end

  def player_type(i)
    type = @io.player_input PLAYER_TYPE + "#{i}" + HUMAN_OR_AI + ENDING_COLON
  end

end
