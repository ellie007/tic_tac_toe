class Board

  attr_accessor :cells

  def initialize
    @cells = Array.new(9) {0}
  end

  def fill_cell(value, sign)
    @cells[value - 1] = sign
    @cells
  end

  def display_board
    line_counter = 0
    @cells.each_with_index do |element, index|
      if element == 1
        print " O "
        line_counter += 1
      elsif element == -1
        print " X "
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




