require './lib/board'

class Player

  attr_accessor :token

  def initialize
    @token = " X "
  end

  def receive_move_input
    user_value = gets.chomp.to_i
  end

end

