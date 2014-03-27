class CommandLineInterface

  WELCOME = "Welcome to the Tic Tac Toe\n"
  USER_TURN  = "Your Turn: "
  AI_TURN = "Watson's Turn: "

  def display_board
    line_counter = 0
    @cells.each_with_index do |element, index|
      if element == "X"
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
