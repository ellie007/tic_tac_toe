require 'optparse'
require './lib/game_instantiation'
require './lib/command_line'

cl_options = {}
OptionParser.new do |opts|
  cl_options[:default] = true

  opts.on('-default') do
    cl_options[:default] = true
  end

  opts.on('-options') do
    cl_options[:default] = false
  end
end.parse!

cl = CommandLine.new
GameInstantiation.new(cl, cl_options).start_game
