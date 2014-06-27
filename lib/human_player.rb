class HumanPlayer

  attr_accessor :name, :token

  def initialize(options, io)
    @name = options[:name]
    @token = options[:token]
    @io = io
  end

  def make_move(_current_player_token, _opponent_player_token, _num_of_players)
    @io.output("#{name}'s Turn: ")
    @io.input
  end

end

