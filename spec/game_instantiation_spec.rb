require 'game_instantiation'
require_relative 'mock_command_line'

describe GameInstantiation do

  let(:mock_io) { MockCommandLine.new }
  let(:game_instantiation) { GameInstantiation.new(mock_io) }

  it 'sends the right welcome message at the beginning of the game' do
    game_instantiation.display_welcome_message

    expect(mock_io.printed_strings[0]).to eq("\nWelcome to Tic Tac Toe!")
  end

end
