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

  context 'player name: ' do
    it 'prompts for player name and capitalizes' do
      allow(mock_io).to receive(:input).and_return('eleanor', 'e', 2)

      expect(menu.get_player_options(0)[:name]).to eq("Eleanor")
    end
  end

  context 'player token: ' do
    it 'prompts for player token' do
      allow(mock_io).to receive(:input).and_return('Alice', 'A', 2)

      expect(menu.get_player_options(0)[:token]).to eq('A')
    end

    it 'takes only the first letter of the player token and capitalizes' do
      allow(mock_io).to receive(:input).and_return('asdf', 'asdf', 2)

      expect(menu.get_player_options(0)[:token]).to eq('A')
    end

    it 'only takes alphabet letters for token, reprompts if any other character' do
      allow(mock_io).to receive(:input).and_return('Alice', 1234, 'a', 2)
    end
  end

  context 'player type: ' do
    it 'prompts for player type' do
      allow(mock_io).to receive(:input).and_return('fake_name', 'f', 1)

      expect(menu.get_player_options(0)[:type]).to eq(1)
    end

    it 'only allows player type of human or ai, if not, reprompts' do
      allow(mock_io).to receive(:input).and_return('fake_name', 'f', 3, 1)
    end
  end

  it 'gets the player name, then token, then type' do
    allow(mock_io).to receive(:input).and_return('eleanor', 'e', 1)

    expect(menu.get_player_options(0)).to eq({:name => "Eleanor", :token => 'E', :type => 1})
  end

end
