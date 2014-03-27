require './lib/board'

class Ai

  attr_accessor :token

  def initialize(cells)
    @cells = cells
    @token = " O "
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
