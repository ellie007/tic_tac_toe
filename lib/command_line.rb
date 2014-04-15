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

  def play_again_output(message)
    print "\n" + message
    play_again_input = gets.chomp.downcase
  end

  def clear_screen
    system('clear')
  end

end


