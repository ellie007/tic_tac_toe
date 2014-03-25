class Board

  attr_accessor :cells

  def initialize
    @cells = Array.new(9) {0}
  end

  def fill_cell(value, sign)
    @cells[(value-1)] = sign
    display_board
    @cells
  end

  def display_board
    @cells.each_with_index do |element, index|
      if element == 1
        print " o "
      elsif element == -1
        print " x "
      else
        print " #{index + 1} "
      end
    end
    print "\n"
    return @cells
  end

end




