require './lib/game_instantiation'
require './lib/command_line'

options_parser = {}

cl = CommandLine.new
GameInstantiation.new(cl, options_parser).start_game
