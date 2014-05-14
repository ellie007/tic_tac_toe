require './lib/board'
require './lib/ai'
require './lib/player'
require './lib/game'
require './lib/command_line'
require './lib/menu'
require './lib/game_rules'

game = Game.new({},{},{},{},{},{},{})

while game.play_again do
  menu = Menu.new
  menu.get_options

  board = Board.new(menu.size)
  ai = Ai.new(board.cells)
  player_1 = Player.new
  player_2 = Player.new
  cl = CommandLine.new(board)
  game_rules = GameRules.new(board)
  game = Game.new(board, ai, cl, menu, player_1, player_2, game_rules)

  game.run
end


