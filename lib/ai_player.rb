class AiPlayer

  attr_accessor :name, :token

  def initialize(name, token, ai, io)
    @name = name
    @token = token
    @ai = ai
    @io = io
  end

  def make_move
    move = @ai.find_move
    @io.output_message(self.name + "'s Turn: #{move}")
    move
  end

end
