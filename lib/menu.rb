class Menu

  WELCOME = "\nWelcome to Tic Tac Toe!"
  DIMENSION_TYPE = "\nWould you like to play 2D or 3D? (enter 2 or 3): "
  BOARD_SIZE = "\nWhat board size would you like?\nPlease enter the base dimension.  (3 for 3 by 3; 4 for 4 by 4): "

  GAME_TYPE_OPTION = "1) Human vs. Human\n2) Human vs. Computer\n3) Computer vs. Computer\nPlease enter a type of game: "
  GAME_TYPE_1 = "\nYou entered Human vs. Human."
  GAME_TYPE_2 = "\nYou entered Human vs. Computer."
  GAME_TYPE_3 = "\nYou entered Computer vs. Computer."

  PLAYER_ONE_NAME = "Please enter Player One's Name: "
  PLAYER_TWO_NAME = "Please enter Player Two's Name: "
  PLAYER_ONE_TOKEN = "What token value would Player One like?: "
  PLAYER_TWO_TOKEN = "What token value would Player Two like?: "

  PLAYER_NAME = "Please enter your name: "
  COMPUTER_NAME = "Please enter the Computer's name: "
  PLAYER_TOKEN = "What would you like your token to be: "
  COMPUTER_TOKEN = "What would you like the Computer's token to be: "

  COMPUTER_NAME_ONE = "Please enter Computer One's Name: "
  COMPUTER_NAME_TWO = "Please enter Computer Two's Name: "
  COMPUTER_TOKEN_ONE = "Computer One's token: "
  COMPUTER_TOKEN_TWO = "Computer Two's token: "

  TURN_RESPONSE = "Would you like to go first or second? (Enter 1 or 2): "

  attr_accessor :size, :dimension_type, :dimension_size, :game_type_response, :player_one_name, :player_two_name, :player_one_token, :player_two_token, :turn_response

  def initialize
    @size
    @dimension_type
    @dimension_size
    @game_type_response
    @player_one_name
    @player_two_name
    @player_one_token
    @player_two_token
    @turn_response
  end

  def get_options
    puts WELCOME + "\n"
    dimension_type
    board_size
    game_type
    player_detail
  end

  def dimension_type
    print DIMENSION_TYPE
    @dimension_type = gets.chomp.to_i
  end

  def board_size
    print BOARD_SIZE
    @size = gets.chomp.to_i
    @dimension_size = @size ** @dimension_type
  end

  def game_type
    until @game_type_response == 1 || @game_type_response == 2 || @game_type_response == 3 do
      print "\n" + GAME_TYPE_OPTION
      @game_type_response = gets.chomp.to_i
    end
  end

  def player_detail
    case @game_type_response
    when 1
      print GAME_TYPE_1
      players_names PLAYER_ONE_NAME, PLAYER_TWO_NAME
      players_token_values PLAYER_ONE_TOKEN, PLAYER_TWO_TOKEN
    when 2
      print GAME_TYPE_2 + "\n"

      until @turn_response == 1 || @turn_response == 2 do
        print TURN_RESPONSE
        @turn_response = gets.chomp.to_i
      end

      if @turn_response == 1
        players_names PLAYER_NAME, COMPUTER_NAME
        players_token_values PLAYER_TOKEN, COMPUTER_TOKEN
      elsif @turn_response == 2
        players_names2 COMPUTER_NAME, PLAYER_NAME
        players_token_values2 COMPUTER_TOKEN, PLAYER_TOKEN
      end
    when 3
      print GAME_TYPE_3
      players_names COMPUTER_NAME_ONE, COMPUTER_NAME_TWO
      players_token_values COMPUTER_TOKEN_ONE, COMPUTER_TOKEN_TWO
    end
  end

  def players_names message1, message2
    print "\n" + message1
    @player_one_name = gets.capitalize.chomp
    print message2
    @player_two_name = gets.capitalize.chomp
  end

  def players_names2 message1, message2
    print "\n" + message1
    @player_two_name = gets.capitalize.chomp
    print message2
    @player_one_name = gets.capitalize.chomp
  end

  def players_token_values message1, message2
    print "\n" + message1
    @player_one_token = gets.chomp
    print message2
    @player_two_token = gets.chomp
  end

  def players_token_values2 message1, message2
    print "\n" + message1
    @player_two_token = gets.chomp
    print message2
    @player_one_token = gets.chomp
  end

end
