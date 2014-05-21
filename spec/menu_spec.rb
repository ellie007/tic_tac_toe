require_relative 'mock_command_line'

describe Menu do

  let(:mock_io) { MockCommandLine.new }
  let(:menu) { Menu.new(mock_io) }

  it 'gets options for the players' do
    allow(mock_io).to receive(:player_input).and_return(3)
    menu.get_options

    expect(menu.size).to eq(3)
  end

   it 'sets board size for the players' do
    allow(mock_io).to receive(:player_input).and_return(3)
    menu.board_size

    expect(menu.size).to eq(3)
  end

  it 'sets player name' do
    allow(mock_io).to receive(:player_input).and_return('eleanor')

    expect(menu.player_name(0)).to eq('Eleanor')
  end

  it 'sets player token' do
    allow(mock_io).to receive(:player_input).and_return('asdf')

    expect(menu.player_token(0)).to eq('A')
  end

  it 'sets player type' do
    allow(mock_io).to receive(:player_input).and_return('human')

    expect(menu.player_type(0)).to eq('human')
  end

end
