require './lib/board'

class Player

  attr_accessor :player_sign

  def initialize
    @player_sign = -1
  end

  def make_move
    user_value = gets.chomp.to_i
  end


end

