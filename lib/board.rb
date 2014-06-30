class Board

  attr_accessor :cells, :size, :dimension

  def initialize(size = 3, dimension = 2)
    @size = size
    @dimension = dimension
    @cells = Array.new(size**dimension, nil)
  end

  def fill_cell(value, token)
    @cells[value] = token
    cells
  end

  def available_spaces(node)
    available_spaces = []
    node.each_with_index do |value, index|
      available_spaces << index if value.nil?
    end
    available_spaces
  end

end
