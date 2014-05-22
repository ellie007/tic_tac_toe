class HumanPlayer

  attr_accessor :name, :token

  def initialize(name, token, io)
    @name = name
    @token = token
    @io = io
  end

  def make_move
    move = @io.prompt_for_input(self.name + "'s Turn: ")
  end

end

