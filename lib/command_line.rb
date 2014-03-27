require './ai'
require './player'

class CommandLineInterface

  WELCOME = "Welcome to the Tic Tac Toe\n"
  USER_TURN  = "Your Turn: "
  AI_TURN = "Watson's Turn: "

  def initialize(ai, player)
    @ai = ai
    @player = player
  end

  def display_board
    line_counter = 0
    @cells.each_with_index do |element, index|
      if element == @ai.token
        print @ai.token
        line_counter += 1
      elsif element == @player.token
        print @player.token
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
