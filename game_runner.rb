require './board/lib/board'
require './ai/lib/ai'
require './player/lib/player'

board = Board.new
player = Player.new

game = Game.new()

game.run



