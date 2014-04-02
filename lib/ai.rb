class Ai

  attr_accessor :token

  def initialize(cells)
    @cells = cells
    @token = " O "
  end

  def find_move
    available_cells = []
    @cells.each_with_index do |value, index|
      available_cells << index if value == "   "
    end
    available_cells.sample + 1
  end

end
