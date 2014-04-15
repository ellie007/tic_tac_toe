require './lib/board'
require './lib/ai'
require './lib/player'
require './lib/game'
require './lib/command_line'
require './lib/menu'

game = Game.new({},{},{},{},{},{})

while game.play_again do
  menu = Menu.new
  menu.get_options

  board = Board.new(menu.size)
  ai = Ai.new(board.cells)
  player_1 = Player.new#(menu.type)
  player_2 = Player.new#(menu.type)
  cl = CommandLine.new(board.cells, ai, board.size, player_1, player_2)
  game = Game.new(board, ai, cl, menu, player_1, player_2)

  game.run
end


