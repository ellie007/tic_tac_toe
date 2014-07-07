require './lib/game_instantiation'
require './lib/command_line'

io = CommandLine.new
GameInstantiation.new(io).start_game
