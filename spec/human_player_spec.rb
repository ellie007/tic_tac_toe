require './spec/mock_command_line'
require './lib/human_player'

describe HumanPlayer do

  it 'gets human player input and sends to the board' do
    mock_io = MockCommandLine.new
    player = HumanPlayer.new('fake name', 'X', mock_io)
    allow(mock_io).to receive(:prompt_for_input).and_return(1)

    player.make_move.should == 1
  end

end




