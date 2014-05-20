class Menu

  WELCOME = "\nWelcome to Tic Tac Toe!"
  BOARD_SIZE = "\nWhat board size would you like?\nPlease enter the base dimension.  (3 for 3 by 3; 4 for 4 by 4): "
  NUM_OF_PLAYERS = "How many players would you like? (1 to 4): "

  attr_accessor :size, :num_of_players, :players

  def initialize
    @players = []
  end

  def get_options
    puts WELCOME + "\n"
    board_size
    number_of_players
  end

  def board_size
    print BOARD_SIZE
    @size = gets.chomp.to_i
  end

  def number_of_players
    self.num_of_players = 0
    until self.num_of_players.between?(1, 4) do
      print "\n" + NUM_OF_PLAYERS
      self.num_of_players = gets.chomp.to_i
    end
  end

  def get_name(num)
    new_player_name = nil
    print "\nPlease enter Player " + num.to_s + "'s Name: "
    new_player_name = gets.capitalize.chomp
    valid_name_check(new_player_name, num)
  end

  def get_token(num)
    new_player_token = nil
    print "Enter token value for Player " + num.to_s + ": "
    new_player_token = gets.capitalize.chomp[0]
    valid_token_check(new_player_token, num)
  end

  def get_type(num)
    player_type = nil
    until player_type == 'human' || player_type == 'ai' do
      print "What type of player is Player " + num.to_s + " (human or ai)?: "
      player_type = gets.chomp
    end
    player_type
  end


private

  def valid_name_check(new_player_name, num)
    if @players.any? { |player| player.name == new_player_name }
      puts "\nPlayer name already taken."
      get_name(num)
    else
      new_player_name
    end
  end

  def valid_token_check(new_player_token, num)
    if @players.any? { |player| player.token == new_player_token }
      puts "\nPlayer token already taken."
      get_token(num)
    else
      new_player_token
    end
  end


end
