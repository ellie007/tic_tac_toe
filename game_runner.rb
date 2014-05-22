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

players = []

(1..2).each do |i|
  name = menu.get_player_name(i)
  token = menu.get_player_token(i)
  type = menu.get_player_type(i)

  if type == 1
    player = HumanPlayer.new(name, token, cl)
  elsif type == 2
    player = AiPlayer.new(name, token, ai, cl)
  end

  players << player
end

game_rules = GameRules.new(board)
game = Game.new(board, ai, cl, menu, players, game_rules)

game.run



