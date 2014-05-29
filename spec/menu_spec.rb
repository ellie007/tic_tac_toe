require 'menu'
require_relative 'mock_command_line'

describe Menu do

  let(:mock_io) { MockCommandLine.new }
  let(:menu) { Menu.new(mock_io) }

  it 'gets and sets board size for the players' do
    allow(mock_io).to receive(:input_prompt).and_return(3)

    expect(menu.get_board_size).to eq(3)
  end

  it 'prompts for player name and capitalizes' do
    allow(mock_io).to receive(:input_prompt).and_return('eleanor')

    expect(menu.get_player_options(0)[:name]).to eq("Eleanor")
  end

  it 'prompts for player token' do
    allow(mock_io).to receive(:input_prompt).and_return('A')

    expect(menu.get_player_options(0)[:token]).to eq('A')
  end

  it 'takes only the first letter of the player token and capitalizes' do
    allow(mock_io).to receive(:input_prompt).and_return('asdf')

    expect(menu.get_player_options(0)[:token]).to eq('A')
  end

  it 'prompts for player type' do
    allow(mock_io).to receive(:input_prompt).and_return('1')

    expect(menu.get_player_options(0)[:type]).to eq(1)
  end

  it 'gets the player name, then token, then type' do
    allow(mock_io).to receive(:input_prompt).and_return('eleanor', 'e', 1)

    expect(menu.get_player_options(0)).to eq({:name => "Eleanor", :token => 'E', :type => 1})
  end

end
