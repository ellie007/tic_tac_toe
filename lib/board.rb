class Board

  attr_reader :cells
  attr_accessor :size, :dimension_response

  def initialize(size, dimension)
    @size = size
    @dimension_response = size ** dimension
    @cells = Array.new(size**dimension, nil)
  end

  def fill_cell(value, token)
    @cells[value - 1] = token
    @cells
  end

end




