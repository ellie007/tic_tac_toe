require_relative 'ai_player'
require_relative 'human_player'

class PlayerFactory

  def initialize(easy_ai, hard_ai, io)
    @easy_ai = easy_ai
    @hard_ai = hard_ai
    @io = io
  end

  def create_player(i)
    player_options = get_player_options(i)
    if player_options[:player_type] == 1
      player = HumanPlayer.new(@io)
    elsif player_options[:player_type] == 2 && player_options[:computer_player_type] == 1
      player = AiPlayer.new(@easy_ai)
    elsif player_options[:player_type] == 2 && player_options[:computer_player_type] == 2
      player = AiPlayer.new(@hard_ai)
    end
    player.name = player_options[:name]
    player.token = player_options[:token]
    player
  end

  def get_player_options(i)
    { :name => get_player_name(i),
      :token => get_player_token(i),
      :player_type => get_player_type(i),
      :computer_player_type => get_computer_player_type(i) }
  end

  def get_player_name(i)
    @io.output(player_name_prompt(i))
    @io.input.capitalize
  end

  def get_player_token(i)
    @io.output(player_token_prompt(i))
    player_token = (@io.input.to_s)[0].capitalize
    if !('A'..'Z').include?(player_token)
      get_player_token(i)
    else
      return player_token
    end
  end

  def get_player_type(i)
    @io.output(player_type_prompt(i))
    @player_type = @io.input.to_i
    if @player_type != 1 && @player_type != 2
      get_player_type(i)
    else
      return @player_type
    end
  end

  def get_computer_player_type(i)
    return nil if @player_type == 1
#   return 1 if @board_size == 4 || @board_dimension == 3 || @num_of_players != 2

    @io.output(computer_player_type_prompt(i))
    computer_player_type = @io.input.to_i
    if computer_player_type != 1 && computer_player_type != 2
      get_computer_player_type(i)
    else
      return computer_player_type
    end
  end

  def player_name_prompt(i)
    "Enter NAME for Player #{i}: "
  end

  def player_token_prompt(i)
    "Enter TOKEN for Player #{i} (A to Z): "
  end

  def player_type_prompt(i)
    "Enter TYPE for Player #{i} (1 for HUMAN, 2 for AI): "
  end

  def computer_player_type_prompt(i)
    "What computer player type would you like for Player #{i}? (1 for EASY, 2 for HARD): "
  end

 end
