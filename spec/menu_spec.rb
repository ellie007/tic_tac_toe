require 'menu'
require_relative 'mock_command_line'

describe Menu do

  let(:mock_io) { MockCommandLine.new }
  let(:menu) { Menu.new(mock_io) }

  it 'gets and sets board size' do
    allow(mock_io).to receive(:input).and_return(3)

    expect(menu.get_board_size).to eq(3)
  end

  it 'gets and sets board dimension type' do
    allow(mock_io).to receive(:input).and_return(3)

    expect(menu.get_board_dimension).to eq(3)
  end

  it 'gets and sets number of players for a game' do
    allow(mock_io).to receive(:input).and_return(5)

    expect(menu.get_number_of_players).to eq(5)
  end

end
