class Menu

  WELCOME = "\nWelcome to Tic Tac Toe!"
  BOARD_SIZE = "\nWhat board size would you like?\nPlease enter the base dimension.  (3 for 3 by 3; 4 for 4 by 4): "

  NUM_OF_PLAYERS = "How many players would you like? (1 to 4): "

  PLAYER_ONE_NAME = "Please enter Player One's Name: "
  PLAYER_TWO_NAME = "Please enter Player Two's Name: "
  PLAYER_THREE_NAME = "Please enter Player Three's Name: "
  PLAYER_FOUR_NAME = "Please enter Player Four's Name: "

  PLAYER_ONE_TOKEN = "What token value would Player One like?: "
  PLAYER_TWO_TOKEN = "What token value would Player Two like?: "
  PLAYER_THREE_TOKEN = "What token value would Player Three like?: "
  PLAYER_FOUR_TOKEN = "What token value would Player Four like?: "

  PLAYER_ONE_TYPE = "What type of player is Player One (human or ai)?: "
  PLAYER_TWO_TYPE = "What type of player is Player Two (human or ai)?: "
  PLAYER_THREE_TYPE = "What type of player is Player Three (human or ai)?: "
  PLAYER_FOUR_TYPE = "What type of player is Player Four (human or ai)?: "

  attr_accessor :size, :num_of_players,
  :player_1_name, :player_2_name, :player_3_name, :player_4_name,
  :player_1_token, :player_2_token, :player_3_token, :player_4_token,
  :player_1_type, :player_2_type, :player_3_type, :player_4_type

  PLAYERS_ARRAY = []

  def get_options
    puts WELCOME + "\n"
    board_size
    number_of_players
    player_detail
  end

  def board_size
    print BOARD_SIZE
    @size = gets.chomp.to_i
  end

  def number_of_players
    print "\n" + NUM_OF_PLAYERS
    @num_of_players = gets.chomp.to_i
  end

  def player_detail
    player_1 PLAYER_ONE_NAME, PLAYER_ONE_TOKEN, PLAYER_ONE_TYPE
    PLAYERS_ARRAY << player_1
    case @num_of_players
    when 2
      player_2 PLAYER_TWO_NAME, PLAYER_TWO_TOKEN, PLAYER_TWO_TYPE
      PLAYERS_ARRAY << player_2
    when 3
      player_2 PLAYER_TWO_NAME, PLAYER_TWO_TOKEN, PLAYER_TWO_TYPE
      player_3 PLAYER_THREE_NAME, PLAYER_THREE_TOKEN, PLAYER_THREE_TYPE
      PLAYERS_ARRAY << player_2
      PLAYERS_ARRAY << player_3
    when 4
      player_2 PLAYER_TWO_NAME, PLAYER_TWO_TOKEN, PLAYER_TWO_TYPE
      player_3 PLAYER_THREE_NAME, PLAYER_THREE_TOKEN, PLAYER_THREE_TYPE
      player_4 PLAYER_FOUR_NAME, PLAYER_FOUR_TOKEN, PLAYER_FOUR_TYPE
      PLAYERS_ARRAY << player_2
      PLAYERS_ARRAY << player_3
      PLAYERS_ARRAY << player_4
    end
  end

  def players_list
    PLAYERS_ARRAY
  end

  def player_1 name, token, type
    print "\n" + name
    @player_1_name = gets.capitalize.chomp
    print token
    @player_1_token = gets.capitalize.chomp
    print type
    @player_1_type = gets.chomp
  end

  def player_2 name, token, type
    print "\n" + name
    @player_2_name = gets.capitalize.chomp
    print token
    @player_2_token = gets.capitalize.chomp
    print type
    @player_2_type = gets.chomp
  end

  def player_3 name, token, type
    print "\n" + name
    @player_3_name = gets.capitalize.chomp
    print token
    @player_3_token = gets.capitalize.chomp
    print type
    @player_3_type = gets.chomp
  end

  def player_4 name, token, type
    print "\n" + name
    @player_4_name = gets.capitalize.chomp
    print token
    @player_4_token = gets.capitalize.chomp
    print type
    @player_4_type = gets.chomp
  end

end
