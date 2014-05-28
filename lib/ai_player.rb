class AiPlayer

  attr_accessor :name, :token

  def initialize(name, token, ai)
    @name = name
    @token = token
    @ai = ai
  end

  def make_move
    @ai.find_move
  end

end
