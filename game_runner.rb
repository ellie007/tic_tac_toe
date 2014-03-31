require './lib/board'
require './lib/ai'
require './lib/player'
require './lib/game'
require './lib/command_line'

board = Board.new
ai = Ai.new(board.cells)
player = Player.new
game = Game.new(board, ai, player)
cl = CommandLine.new(game, board.cells, ai, player)

puts CommandLine::WELCOME
cl.display_board

while !game.winner do
  print "\n"
  print CommandLine::USER_TURN
  player_move = cl.player_move_input
  until game.valid_input?(player_move) == true do
    puts CommandLine::INVALID_INPUT
    print CommandLine::USER_TURN
    player_move = cl.player_move_input
  end
  until game.valid_cell?(player_move) == false do
    puts CommandLine::INVALID_CELL
    print CommandLine::USER_TURN
    player_move = cl.player_move_input
  end
  game.human_turn(player_move)
  cl.display_board
  break if game.winner

  ai_move = ai.find_move
  puts CommandLine::AI_TURN + "#{ai_move}"
  game.ai_turn(ai_move)
  cl.display_board
  game.winner
end

cl.winner_display

