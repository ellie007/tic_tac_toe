class CommandLine

  def initialize(cells, ai, player)
    @cells = cells
    @ai = ai
    @player = player
  end

  def output_message(message)
    print message
  end

  def display_board_row(element, index)
    if element != "   "
      print element
    else
      print " #{index + 1} "
    end
  end

  def display_board
    line_counter = 0
    @cells.each_with_index do |element, index|
      display_board_row(element, index)
      line_counter += 1
      print "\n" if line_counter % 3 == 0
    end
  end

  def player_input
    move = gets.chomp.to_i
  end

end
