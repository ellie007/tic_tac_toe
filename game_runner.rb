require './lib/board'
require './lib/ai'
require './lib/human_player'
require './lib/game'
require './lib/command_line'
require './lib/menu'
require './lib/game_rules'

puts "\nWelcome to Tic Tac Toe!"

cl = CommandLine.new
menu = Menu.new(cl)
menu.get_board_size
board = Board.new(menu.board_size)
ai = Ai.new(board.cells)

players = []

(0..1).each do |i|
  player = HumanPlayer.new(menu.get_player_name(i), menu.get_player_token(i), cl)
  players << player
end

game_rules = GameRules.new(board)
game = Game.new(board, ai, cl, menu, players, game_rules)
game.run



