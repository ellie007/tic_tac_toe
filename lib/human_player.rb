class HumanPlayer

  attr_accessor :name, :token

  def initialize(io)
    @io = io
  end

  def make_move(_current_player_token, _opponent_player_token, _num_of_players, _board)
    @io.output("#{name}'s Turn: ")
    @io.input
  end

end

