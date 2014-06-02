class Board

  attr_accessor :cells

  def initialize(size = 3)
    @cells = Array.new(size**2, nil)
  end

  def fill_cell(value, token)
    @cells[value - 1] = token
    @cells
  end

  def size
    Math.sqrt(@cells.length)
  end

end




