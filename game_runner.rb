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
  player = Player.new
  cl = CommandLine.new(board.cells, ai, player, board.size)
  game = Game.new(board, ai, player, cl, board.size, menu)

  game.run
end


