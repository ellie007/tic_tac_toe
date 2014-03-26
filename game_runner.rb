require './lib/board'
require './lib/ai'
require './lib/player'
require './lib/game'

board = Board.new
ai = Ai.new(board.cells)
player = Player.new

game = Game.new(board, ai, player)

print welcome message

while !game.winner
  move = gets.chomps
  game.player_move(move)
  cl.display board
end
  game.game_over


game.run



