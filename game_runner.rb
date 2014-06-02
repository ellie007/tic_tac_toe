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
board = Board.new(menu.get_board_size)
ai = Ai.new(board.cells)
game_rules = GameRules.new(board)

options = { :board => board, :ai => ai, :io => cl, :menu => menu, :game_rules => game_rules }

game = Game.new(options)

game.run



