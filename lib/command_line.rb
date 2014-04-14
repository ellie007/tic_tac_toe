class CommandLine

  def initialize(cells, ai, player, size)
    @cells = cells
    @ai = ai
    @player = player
    @size = size
  end

  def output_message(message)
    puts "\n" + message
  end

  def display_board_row(element, index)
    if element != nil
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
      print "\n" if line_counter % @size == 0
    end
  end

  def player_input(message)
    print "\n" + message
    move = gets.chomp.to_i
  end

  def same_line(message)
    print "\n" + message
  end

end


