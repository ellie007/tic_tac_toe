require './lib/ai'
require './lib/player'

class CommandLine

  WELCOME = "Welcome to Tic Tac Toe"
  USER_TURN  = "Your Turn: "
  AI_TURN = "Watson's Turn: "
  INVALID_INPUT = "That is invalid input.  Please choose open spaces 1 to 9."
  INVALID_CELL = "That spot is already taken.  Please choose an empty spot."
  TIE = "It is a tie game."
  WATSON_WON = "Watson Won!"
  YOU_WON = "You Won!"

  def initialize(game, cells, ai, player)
    @game = game
    @cells = cells
    @ai = ai
    @player = player
  end

  def display_board_element(element, index)
    if element != "   "
      print element
    else
      print " #{index + 1} "
    end
  end

  def display_board
    line_counter = 0
    @cells.each_with_index do |element, index|
      display_board_element(element, index)
      line_counter += 1
      print "\n" if line_counter % 3 == 0
    end
  end

  def player_move_input
    user_value = gets.chomp.to_i
  end

  def winner_display
    winner = @game.winner
    puts WATSON_WON if winner == @ai.token
    puts YOU_WON if winner == @player.token
  end

end
