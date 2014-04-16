class Menu

  WELCOME = "\nWelcome to Tic Tac Toe!"
  BOARD_SIZE = "\nWhat board size would you like?\nPlease enter the base dimension.  (3 for 3 by 3; 4 for 4 by 4): "
  "\nYou entered Human vs. Human."

  GAME_TYPE_OPTION = "1) Human vs. Human\n2) Human vs. Computer\n3) Computer vs. Computer\nPlease enter a type of game: "
  GAME_TYPE_1 = "\nYou entered Human vs. Human."
  GAME_TYPE_2 = "\nYou entered Human vs. Computer."
  GAME_TYPE_3 = "\nYou entered Computer vs. Computer."

  PLAYER_ONE_NAME = "Please enter Player One's Name : "
  PLAYER_TWO_NAME = "Please enter Player Two's Name : "

  PLAYER_ONE_TOKEN = "\nWhat token value would Player One like?: "
  PLAYER_TWO_TOKEN = "What token value would Player Two like?: "

  TURN_RESPONSE = "Would you like to go first or second? (Enter 1 or 2): "

  attr_accessor :size, :game_type_response, :player_one_name, :player_two_name, :player_one_token, :player_two_token, :turn_response

  def initialize
    @size
    @game_type_response
    @player_one_name
    @player_two_name
    @player_one_token
    @player_two_token
    @turn_response
  end

  def get_options
    puts WELCOME + "\n"
    board_size
    game_type
    player_detail
  end

  def board_size
    print BOARD_SIZE
    @size = gets.chomp.to_i
  end

  def game_type
    print "\n" + GAME_TYPE_OPTION
    @game_type_response = gets.chomp.to_i
  end

  def player_detail
    case @game_type_response
    when 1
      print GAME_TYPE_1
    when 2
      print GAME_TYPE_2 + "\n"
      print TURN_RESPONSE
      @turn_response = gets.chomp.to_i
    when 3
      print GAME_TYPE_3
    end
    players_names
    players_token_values
  end

  def players_names
    print "\n" + PLAYER_ONE_NAME
    @player_one_name = gets.chomp
    print PLAYER_TWO_NAME
    @player_two_name = gets.chomp
  end

  def players_token_values
    print PLAYER_ONE_TOKEN
    @player_one_token = gets.chomp
    print PLAYER_TWO_TOKEN
    @player_two_token = gets.chomp
  end

end
