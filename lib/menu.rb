class Menu

  WELCOME = "Welcome to Tic Tac Toe!"
  NAME = "\nPlease enter your name: "
  BOARD_SIZE = "\nWhat board size would you like?\nPlease enter the base dimension.  (3 for 3 by 3; 4 for 4 by 4): "
  TURN = "\nWould you like to go first or second? (enter 1st or 2nd): "

  GAME_TYPE_OPTION = "Please enter a type of game:\n1) Human vs. Human\n2) Human vs. Computer\n3) Computer vs. Computer"

  attr_accessor :human_player_name, :size, :turn_response

  def initialize
    @human_player_name
    @size
    @turn_response
  end

  def get_options
    puts WELCOME + "\n"
    player_name
    board_size
    turn
  end

  def player_name
    print NAME
    @human_player_name = gets.chomp
  end

  def board_size
    print BOARD_SIZE
    @size = gets.chomp.to_i
  end

  def turn
    print TURN
    @turn_response = gets.chomp
  end


end
