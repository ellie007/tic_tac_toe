class AiPlayer

  attr_accessor :name, :token

  def initialize(options, ai)
    @name = options[:name]
    @token = options[:token]
    @ai = ai
  end

  def make_move
    @ai.find_move
  end

end
