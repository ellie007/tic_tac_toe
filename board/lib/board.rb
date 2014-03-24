class Board

  def initialize
    @cells = Array.new(9) {0}
  end

  def fill_cell(value, sign)
    @cells[value - 1] = sign
    display_board
  end

  def display_board
    @cells.each_with_index do |element, index|

      if element == 1
        print " x "
      elsif element == -1
        print " o "
      else
        print " #{index + 1} "
      end
    end
    return @cells
  end

end




