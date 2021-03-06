class CommandLine

  attr_accessor :size, :dimension

  def display_board(cells)
    print_new_line
    puts "Current State of Game:"
    cells.each_with_index do |element, index|
      display_element(element, index)
      board_separator if end_of_board?(index)
      print_new_line if new_board_row?(index)
      row_separator if new_board_row?(index) && !end_of_board?(index)
    end
    legend(cells)
  end

  def legend(cells)
    print_new_line
    puts "Legend:"
    cells.each_with_index do |element, index|
      if size < 4 && dimension == 2
        print " #{index} "
      else 
        print "  #{index} " if index < 10
        print " #{index} " if index > 9
      end
      board_separator if end_of_board?(index)
      print_new_line if new_board_row?(index)
    end
    legend_options
  end

  def input
    gets.chomp
  end

  def output(message)
    print_new_line
    print message
  end

  def clear_screen
    system('clear')
  end

private

  def legend_options
    print_new_line
    puts "Please enter a number to place a token there."
    print_new_line
    puts "Enter at anytime:\nMENU to restart with new options\nRESTART to begin again with same options\nQUIT to leave the game."
  end

  def display_element(element, index)
    if element.nil?
      print_empty_space(index)
    else
      print_element(element, index)
    end
  end

  def print_element(element, index)
    if new_board_row?(index)
      print " #{element} "
    else
      print " #{element} |"
    end
  end

  def print_empty_space(index)
    if new_board_row?(index)
      print "   "
    else
      print "   |"
    end
  end

  def row_separator
    puts "---+" * (size - 1) + "---"
  end

  def board_separator
    print "\n" if dimension == 3
  end

  def new_board_row?(index)
    (index + 1) % size == 0
  end

  def end_of_board?(index)
    (index + 1) % size**2 == 0
  end

  def print_new_line
    print "\n"
  end

end

