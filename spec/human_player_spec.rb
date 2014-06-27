require 'human_player'
require_relative 'mock_command_line'

describe HumanPlayer do

  let(:mock_io) { MockCommandLine.new }
  let(:options) { {:name => 'fake_name', :token => 'X'} }
  let(:human_player) { HumanPlayer.new(options, mock_io) }

  it 'gets human player input' do
    allow(mock_io).to receive(:input).and_return(1)

    expect(human_player.make_move({}, {}, {})).to eq(1)
  end

end




