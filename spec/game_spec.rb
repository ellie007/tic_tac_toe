require 'game'
require 'board'
require 'ai'
require 'human_player'
require 'ai_player'
require 'menu'
require 'game_rules'
require_relative 'mock_command_line'

describe Game do

  let(:mock_io) { MockCommandLine.new }
  let(:menu) { Menu.new(mock_io) }
  let(:board) { Board.new(3) }
  let(:ai) { Ai.new(board.cells) }
  let(:player_1) { HumanPlayer.new("Eleanor", "E", mock_io) }
  let(:player_2) { AiPlayer.new("Vivian", "V", ai) }
  let(:game_rules) { GameRules.new(board) }

  let(:options) { { :board => board, :ai => ai, :io => mock_io, :menu => menu, :game_rules => game_rules } }

  let(:game) { Game.new(options) }

  it 'creates a set of players' do
    allow(menu).to receive(:get_player_name).and_return('fake_name')
    allow(menu).to receive(:get_player_token).and_return('fake_token')
    allow(menu).to receive(:get_player_type).and_return(1, 2)
    game.set_players

    expect(game.players.length).to eq(2)
  end

  context "make move: " do
    it "makes a move for a human" do
      game.players = [player_1, player_2]
      game.set_current_player
      allow(game.current_player).to receive(:make_move).and_return(1)
      game.make_move

      expect(board.cells).to eq([ "E", nil, nil,
                                   nil, nil, nil,
                                   nil, nil, nil ])
    end

    it "keeps prompting human for input until valid input (with correct prompts)" do
      game.players = [player_1, player_2]
      game.set_current_player
      allow(mock_io).to receive(:input_prompt).and_return(123, 'apple', 5)
      game.make_move

      expect(mock_io.printed_strings[0]).to match /Eleanor's Turn: /
      expect(mock_io.printed_strings[1]).to match /That is invalid input./
      expect(mock_io.printed_strings[2]).to eq(mock_io.display_board_message)

      expect(mock_io.printed_strings[3]).to match /Eleanor's Turn: /
      expect(mock_io.printed_strings[4]).to match /That is invalid input./
      expect(mock_io.printed_strings[5]).to eq(mock_io.display_board_message)

      expect(mock_io.printed_strings[6]).to match /Eleanor's Turn: /
      expect(mock_io.printed_strings[7]).to match /Eleanor made the move: 5/
      expect(mock_io.printed_strings[8]).to eq(mock_io.display_board_message)

      expect(board.cells[4]).to eq(player_1.token)
    end

    it "keeps prompting human for input until valid cell (with correct prompts)" do
      game.players = [player_1, player_2]
      game.set_current_player
      board.cells = [ "X", nil, nil,
                      nil, nil, nil,
                      nil, nil, nil ]

      allow(mock_io).to receive(:input_prompt).and_return(1, 2)
      game.make_move

      expect(mock_io.printed_strings[0]).to match /Eleanor's Turn: /
      expect(mock_io.printed_strings[1]).to match /That spot is already taken./
      expect(mock_io.printed_strings[2]).to eq(mock_io.display_board_message)

      expect(mock_io.printed_strings[3]).to match /Eleanor's Turn: /
      expect(mock_io.printed_strings[4]).to match /Eleanor made the move: 2/
      expect(mock_io.printed_strings[5]).to eq(mock_io.display_board_message)

      expect(board.cells[1]).to eq(player_1.token)
    end
  end

  context "ai turn" do
    it "ai gets random move, sends correct message, and fills the board" do
      game.current_player = player_2
      #ai.stub find_move: 5
      allow(game.current_player).to receive(:make_move).and_return(5)
      game.make_move

      expect(mock_io.printed_strings[0]).to match /Vivian made the move: 5/
      expect(mock_io.printed_strings[1]).to eq(mock_io.display_board_message)

      expect(board.cells[4]).to eq(game.current_player.token)
    end
  end

  it 'toggles the current player' do
    game.players = [player_1, player_2]
    game.current_player = player_2
    game.toggle_current_player

    expect(game.current_player).to eq(player_1)
  end

  context "set winner: " do
    it "sets winner setter method" do
      game.players = [player_1, player_2]
      game.set_current_player
      board.cells = [ "E", nil, nil,
                      nil, "E", nil,
                      nil, nil, "E" ]
      game.display_winner_information

      game.winner.should == player_1.token
    end
  end

  context 'winner_display: ' do
    it "displays the winner of the game when there is a winner" do
      game.players = [player_1, player_2]
      game.set_current_player
      board.cells = [ "E", "E", "E",
                      nil, nil, nil,
                      nil, nil, nil ]

      game.display_winner_information

      expect(mock_io.printed_strings[0]).to eq(mock_io.display_board_message)
      expect(mock_io.printed_strings[1]).to match /eleanor won!/i
    end

    it 'displays it was a tie game' do
      board.cells = [ "E", "E", "V",
                      "V", "V", "E",
                      "E", "E", "V" ]

      game.display_winner_information

      expect(mock_io.printed_strings[1]).to match /tie game/
    end
  end

  context 'asks the player(s) if want play the game again' do
    it 'resets the board if player(s) want to play again' do
      board.cells = [ "E", "E", "V",
                      "V", "V", "E",
                      "E", "E", "V" ]

      allow(mock_io).to receive(:input_prompt).and_return('y')
      game.ask_to_play_again

      expect(board.cells).to eq([ nil, nil, nil,
                                  nil, nil, nil,
                                  nil, nil, nil ])
    end

    it 'sets the setter of play again method as false' do
      allow(mock_io).to receive(:input_prompt).and_return('n')
      game.ask_to_play_again

      expect(game.play_again).to eq(false)
    end
  end

end
