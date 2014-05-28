class HumanPlayer

  attr_accessor :name, :token

  def initialize(name, token, io)
    @name = name
    @token = token
    @io = io
  end

  def make_move
    @io.output_message(name + "'s Turn: ")
    @io.input_prompt
  end

end

