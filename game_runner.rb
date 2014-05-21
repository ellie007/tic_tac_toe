require './lib/board'
require './lib/ai'
require './lib/player'
require './lib/game'
require './lib/command_line'
require './lib/menu'
require './lib/game_rules'

cl = CommandLine.new
menu = Menu.new(cl)
menu.get_options
board = Board.new(menu.size)
ai = Ai.new(board.cells)

players = []

2.times do |i|
  i += 1
  player = Player.new(menu.player_name(i), menu.player_token(i), menu.player_type(i))
  players << player
end

game_rules = GameRules.new(board)
game = Game.new(board, ai, cl, menu, players, game_rules)
game.run3



