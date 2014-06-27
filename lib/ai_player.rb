class AiPlayer

  attr_accessor :name, :token

  def initialize(options, ai)
    @name = options[:name]
    @token = options[:token]
    @ai = ai
  end

  def make_move(current_player_token, opponenet_player_token, num_of_players)
    @ai.find_move(current_player_token, opponenet_player_token, num_of_players)
  end

end
