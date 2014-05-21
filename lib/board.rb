class Board

  attr_accessor :cells, :size

  def initialize(size)
    @size = size
    @cells = Array.new(size**2, nil)
  end

  def fill_cell(value, token)
    @cells[value - 1] = token
    @cells
  end

end




