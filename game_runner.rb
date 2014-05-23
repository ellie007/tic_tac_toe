require './lib/board'
require './lib/ai'
require './lib/human_player'
require './lib/ai_player'
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
game_rules = GameRules.new(board)
game = Game.new(board, ai, cl, menu, game_rules)

game.run



