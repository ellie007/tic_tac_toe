class Board

  attr_accessor :cells

  def initialize
    @cells = Array.new(9, "   ")
  end

  def fill_cell(value, token)
    @cells[value - 1] = token
    @cells
  end

  def display_board
    line_counter = 0
    @cells.each_with_index do |element, index|
      if element == " X "
        print " X "
        line_counter += 1
      elsif element == " O "
        print " O "
        line_counter += 1
      else
        print " #{index + 1} "
        line_counter += 1
      end
      if line_counter % 3 == 0
        print "\n"
      end
    end
    print "\n"
    return @cells
  end

end




