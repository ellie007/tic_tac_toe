class HumanPlayer

  attr_accessor :name, :token

  def initialize(options, io)
    @name = options[:name]
    @token = options[:token]
    @io = io
  end

  def make_move
    @io.output("#{name}'s Turn: ")
    @io.input
  end

end

