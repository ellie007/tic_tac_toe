require './lib/board'
require './lib/ai'
require './lib/player'
require './lib/game'

board = Board.new
ai = Ai.new(board.cells)
player = Player.new

game = Game.new(board, ai, player)

game.run



