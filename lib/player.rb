require './lib/board'

class Player

  attr_accessor :player_sign

  def initialize
    @player_sign = " X "
  end

  def receive_move_input
    user_value = gets.chomp.to_i
  end

end

