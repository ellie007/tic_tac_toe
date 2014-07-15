class AiPlayer

  attr_accessor :name, :token
  attr_reader :ai

  def initialize(ai)
    @ai = ai
  end

  def make_move(current_player_token, opponenet_player_token, num_of_players, board)
    @ai.find_move(current_player_token, opponenet_player_token, num_of_players, board)
  end

end
