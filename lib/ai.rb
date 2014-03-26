require './lib/board'

class Ai

  attr_accessor :ai_sign

  def initialize(cells)
    @cells = cells
    @ai_sign = " O "
  end

  def find_move
    empty_spots = []
    @cells.each_with_index do |value, index|
      if value == "   "
        empty_spots << index
      end
    end
    empty_spots.sample + 1
  end


end
