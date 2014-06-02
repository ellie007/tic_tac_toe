class Ai

  def initialize(cells)
    @cells = cells
  end

  def find_move
    available_cells = []
    @cells.each_with_index do |value, index|
      available_cells << index if value.nil?
    end
    available_cells.sample + 1
  end

end
