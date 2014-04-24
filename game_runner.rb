require './lib/board'
require './lib/ai'
require './lib/player'
require './lib/game'
require './lib/command_line'
require './lib/menu'
require './lib/game_state'

game = Game.new({},{},{},{},{},{})

while game.play_again do
  menu = Menu.new
  menu.get_options

  board = Board.new(menu.size, menu.dimension_size)
  #game_state = GameState.new(board.cells)
  ai = Ai.new(board.cells)
  player_1 = Player.new
  player_2 = Player.new
  cl = CommandLine.new(board)
  game = Game.new(board, ai, cl, menu, player_1, player_2)

  game.run
end


