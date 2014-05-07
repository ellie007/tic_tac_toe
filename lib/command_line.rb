class CommandLine

  def initialize(board)
    @cells = board.cells
    @size = board.size
  end

  def output_message(message)
    puts "\n" + message
  end

  def display_board_row(element, index)
    if element != nil
      if (index + 1) % @size == 0
        print " #{element} "
      else
        print " #{element} |"
      end
    else
      if (index + 1) % @size == 0
        print "   "
      else
        print "   |"
      end
    end
  end

  def legend
    print "\n"
    puts "Legend:"
    @cells.each_with_index do |element, index|
      print " #{index + 1} "
      print "\n" if (index + 1) % @size == 0
    end
    print "\n"
    puts "Please enter a number to place a token there."
    print "\n"
    puts "Enter at anytime:\nMENU to restart with new options\nRESTART to begin again with same options\nQUIT to leave the game."
  end

  def display_board
    print "\n"
    puts "Current State of Game:"
    @cells.each_with_index do |element, index|
      display_board_row(element, index)
      print "\n" if (index + 1) % @size == 0
      print "---+" * (@size-1) + "---" if (index + 1) % @size == 0 && (index + 1) < @size**2
      print "\n" if (index + 1) % @size == 0 && (index + 1) < @size**2
    end
    legend
  end

  def player_input(message)
    print "\n" + message
    move = gets.chomp.to_i
  end

  def play_again_output(message)
    print "\n" + message
    play_again_input = gets.chomp.downcase
  end

  def clear_screen
    system('clear')
  end

end

