require './lib/board'

class Ai

  def initialize(cells)
    @cells = cells
    @ai_sign = 1
  end

  def find_move
    empty_spots = []
    @cells.each_with_index do |value, index|
      if value == 0
        empty_spots << index
      end
    end
    empty_spots.sample + 1
  end

end
