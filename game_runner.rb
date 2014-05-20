require './lib/board'
require './lib/ai'
require './lib/player'
require './lib/game'
require './lib/command_line'
require './lib/menu'
require './lib/game_rules'

game = Game.new({},{},{},{},{},{})

while game.play_again do
  menu = Menu.new
  menu.get_options

  board = Board.new(menu.size)
  ai = Ai.new(board.cells)

  menu.num_of_players.times do |i|
    player = Player.new(menu.get_name(i+1), menu.get_token(i+1), menu.get_type(i+1))
    menu.players << player
  end

  cl = CommandLine.new(board)
  game_rules = GameRules.new(board)
  game = Game.new(board, ai, cl, menu, menu.players, game_rules)

  game.run
end

