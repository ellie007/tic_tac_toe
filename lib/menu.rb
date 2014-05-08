class Menu

  WELCOME = "\nWelcome to Tic Tac Toe!"
  BOARD_SIZE = "\nWhat board size would you like?\nPlease enter the base dimension.  (3 for 3 by 3; 4 for 4 by 4): "

  NUM_OF_PLAYERS = "How many players would you like? (1 to 4): "

  attr_accessor :size, :num_of_players

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
    print "\n" + NUM_OF_PLAYERS
    @num_of_players = gets.chomp.to_i
  end

  def get_name(num)
    print "\nPlease enter Player " + num.to_s + "'s Name: "
    gets.capitalize.chomp
  end

   def get_token(num)
    print "Enter token value for Player " + num.to_s + ": "
    gets.capitalize.chomp[0]
  end

  def get_type(num)
    player_type = nil
    until player_type == 'human' || player_type == 'ai' do
      print "What type of player is Player " + num.to_s + " (human or ai)?: "
      player_type = gets.chomp
    end
    player_type
  end

end
