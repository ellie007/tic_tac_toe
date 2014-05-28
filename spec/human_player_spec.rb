require 'human_player'
require_relative 'mock_command_line'

describe HumanPlayer do

  let(:mock_io) { MockCommandLine.new }
  let(:human_player) { HumanPlayer.new('fake name', 'X', mock_io) }

  it 'gets human player input' do
    allow(mock_io).to receive(:input_prompt).and_return(1)

    human_player.make_move.should == 1
  end

end




