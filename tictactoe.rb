require 'optparse'
require './lib/game_instantiation'
require './lib/command_line'

options_parser = {}
OptionParser.new do |opts|
  options_parser[:default] = true

  opts.on('-default') do
    options_parser[:default] = true
  end

  opts.on('-custom', '-options') do
    options_parser[:default] = false
  end
end.parse!

cl = CommandLine.new
GameInstantiation.new(cl, options_parser).start_game
