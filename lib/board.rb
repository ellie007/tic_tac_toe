class Board

  attr_accessor :cells

  def initialize
    @cells = Array.new(9, "   ")
  end

  def fill_cell(value, token)
    @cells[value - 1] = token
    @cells
  end

end




