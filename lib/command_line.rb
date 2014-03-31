require './lib/ai'
require './lib/player'

class CommandLine

  WELCOME = "Welcome to Tic Tac Toe"
  USER_TURN  = "Your Turn: "
  AI_TURN = "Watson's Turn: "
  INVALID_INPUT = "That is invalid input.  Please choose open spaces 1 to 9."
  INVALID_CELL = "That spot is already taken.  Please choose an empty spot."


  def initialize(game, cells, ai, player)
    @game = game
    @cells = cells
    @ai = ai
    @player = player
  end

  def display_board
    line_counter = 0
    @cells.each_with_index do |element, index|
      if element == @player.token
        print @player.token
        line_counter += 1
      elsif element == @ai.token
        print @ai.token
        line_counter += 1
      else
        print " #{index + 1} "
        line_counter += 1
      end
      if line_counter % 3 == 0
        print "\n"
      end
    end
    return @cells
  end

  def player_move_input
    user_value = gets.chomp.to_i
  end

  def winner_display
    if @game.winner == @ai.token
      puts "Watson Won!"
    elsif @game.winner == @player.token
      puts "You Won!"
    end
  end

end
