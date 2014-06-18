class Board

  attr_accessor :cells, :size, :dimension

  def initialize(size = 3, dimension = 2)
    @size = size
    @dimension = dimension
    @cells = Array.new(size**dimension, nil)
  end

  def fill_cell(value, token)
    @cells[value] = token
    @cells
  end

end




