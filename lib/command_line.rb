class CommandLine

  def initialize(cells, ai, size, player_1, player_2)
    @cells = cells
    @ai = ai
    @size = size
    @player_1 = player_1
    @player_2 = player_2
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
  end

  def display_board
    print "\n"
    puts "Current state of game:"
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

