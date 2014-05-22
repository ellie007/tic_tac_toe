class HumanPlayer

  attr_accessor :name, :token

  def initialize(name, token, io)
    @name = name
    @token = token
    @io = io
  end

  def make_move
    player_turn_memo = "'s Turn: "
    @io.prompt_for_input(self.name + player_turn_memo)
  end

end

