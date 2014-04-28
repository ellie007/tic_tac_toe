class Board

  attr_reader :cells
  attr_accessor :size, :dimension_type, :dimension_size

  def initialize(size, dimension_type, dimension_size)
    @size = size
    @dimension_type = dimension_type
    @dimension_size = dimension_size
    @cells = Array.new(dimension_size, nil)
  end

  def fill_cell(value, token)
    @cells[value - 1] = token
    @cells
  end

end




