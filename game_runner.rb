require './lib/board'
require './lib/ai'
require './lib/player'
require './lib/game'
require './lib/command_line'




    board = Board.new
    ai = Ai.new(board.cells)
    player = Player.new
    cl = CommandLine.new(board.cells, ai, player)
    game = Game.new(board, ai, player, cl)





game.run

