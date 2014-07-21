require 'easy_ai'
require 'hard_ai'
require_relative 'mock_command_line'
require 'player_factory'

describe PlayerFactory do

  let(:mock_io) { MockCommandLine.new }
  let(:hard_ai) { HardAi.new }
  let(:easy_ai) { EasyAi.new }
  let(:player_factory) { PlayerFactory.new(easy_ai, hard_ai, mock_io) }

  context 'factory class that creates player objects: ' do
    it 'creates a Human type player' do
      allow(mock_io).to receive(:input).and_return('fake_name', 'fake_token', 1)

      expect(player_factory.create_player(0).class).to eq(HumanPlayer)
    end

    it 'creates an Easy Ai type player' do
      allow(mock_io).to receive(:input).and_return('fake_name', 'fake_token', 2, 1)
      expect(player_factory.create_player(0).class).to eq(AiPlayer)

      allow(mock_io).to receive(:input).and_return('fake_name', 'fake_token', 2, 1)
      expect(player_factory.create_player(0).ai.class).to eq(EasyAi)
    end

    it 'creates a Hard Ai type player' do
      allow(mock_io).to receive(:input).and_return('fake_name', 'fake_token', 2, 2)
      expect(player_factory.create_player(0).class).to eq(AiPlayer)

      allow(mock_io).to receive(:input).and_return('fake_name', 'fake_token', 2, 2)
      expect(player_factory.create_player(0).ai.class).to eq(HardAi)
    end
  end

  context 'default player settings: ' do
    it 'creates a set of 2 players' do
      expect(player_factory.create_default_players.count).to eq(2)
    end

    it 'the first default player is a human type/human goes first' do
      expect(player_factory.create_default_players[0].class).to eq(HumanPlayer)
    end

    it 'the second default player is an ai type/computer goes second' do
      expect(player_factory.create_default_players[1].class).to eq(AiPlayer)
    end

    it 'the ai type player implements hard ai' do
      expect(player_factory.create_default_players[1].ai.class).to eq(HardAi)
    end

    it "human player gets token of 'X'" do
      expect(player_factory.create_default_players[0].token).to eq('X')
    end

    it "ai player gets token of 'O'" do
      expect(player_factory.create_default_players[1].token).to eq('O')
    end
  end

  context 'player name: ' do
    it 'prompts for player name and capitalizes' do
      allow(mock_io).to receive(:input).and_return('eleanor', 'e', 2)

      expect(player_factory.get_player_options(0)[:name]).to eq("Eleanor")
    end
  end

  context 'player token: ' do
    it 'prompts for player token' do
      allow(mock_io).to receive(:input).and_return('Alice', 'A', 2)

      expect(player_factory.get_player_options(0)[:token]).to eq('A')
    end

    it 'takes only the first letter of the player token and capitalizes' do
      allow(mock_io).to receive(:input).and_return('asdf', 'jkl;', 2)

      expect(player_factory.get_player_options(0)[:token]).to eq('J')
    end

    it 'only takes alphabet letters for token, reprompts if any other character' do
      allow(mock_io).to receive(:input).and_return('Alice', 1234, 'a', 2)

      expect(player_factory.get_player_options(0)[:token]).to eq('A')
    end
  end

  context 'player type: ' do
    it 'prompts for player type' do
      allow(mock_io).to receive(:input).and_return('fake_name', 'f', 1)

      expect(player_factory.get_player_options(0)[:player_type]).to eq(1)
    end

    it 'only allows player type of human or ai, if not, reprompts' do
      allow(mock_io).to receive(:input).and_return('fake_name', 'f', 3, 1)

      expect(player_factory.get_player_options(0)[:player_type]).to eq(1)
    end
  end

  context 'computer player type: ' do
    it 'prompts for computer player type - assigns easy ai' do
      allow(mock_io).to receive(:input).and_return('fake_name', 'f', 2, 1)

      expect(player_factory.get_player_options(0)[:computer_player_type]).to eq(1)
    end

    it 'prompts for computer player type = assigns hard ai' do
      allow(mock_io).to receive(:input).and_return('fake_name', 'f', 2, 2)

      expect(player_factory.get_player_options(0)[:computer_player_type]).to eq(2)
    end

    it 'reprompts when incorrect computer player type is entered' do
      allow(mock_io).to receive(:input).and_return('fake_name', 'f', 2, 3, 2)

      expect(player_factory.get_player_options(0)[:computer_player_type]).to eq(2)
    end

    it 'does not prompt for computer player type - when player type is not ai' do
      allow(mock_io).to receive(:input).and_return('fake_name', 'f', 1)

      expect(player_factory.get_player_options(0)[:computer_player_type]).to eq(nil)
     end
   end

   it 'gets the player name, then token, then player type, then computer player type' do
     allow(mock_io).to receive(:input).and_return('eleanor', 'e', 2, 1)

     expect(player_factory.get_player_options(0)).to eq({:name => "Eleanor", :token => 'E', :player_type => 2, :computer_player_type => 1})
   end

end
