require './lib/board'
require './lib/ai'
require './lib/player'
require './lib/game'
require './lib/command_line'

play_again = true

while (play_again) do

  print "What board size would you like?\nPlease enter the base dimension.  (3 for 3 by 3; 4 for 4 by 4): "
  board_size = gets.chomp.to_i

  print "Would you like to go first or second? (enter 1st or 2nd): "
  turn_response = gets.chomp.to_i

  board = Board.new(board_size)
  ai = Ai.new(board.cells)
  player = Player.new
  cl = CommandLine.new(board.cells, ai, player, board.size)
  game = Game.new(board, ai, player, cl, board.size)

  if turn_response == "1st"
    game.run1
  else
    game.run2
  end

  print "Would you like to play again (y/n)?: "
  play_again_input = gets.chomp

  if play_again_input == 'y'
    play_again = true
  else
    play_again = false
  end

end


