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
  let(:board) { Board.new }
  let(:ai) { Ai.new(board.cells) }

  let(:human_options) { { :name => 'Eleanor', :token => 'E', :type => 1 } }
  let(:player_1) { HumanPlayer.new(human_options, mock_io) }

  let(:ai_options) { { :name => 'Vivian', :token => 'V', :type => 2 } }
  let(:player_2) { AiPlayer.new(ai_options, ai) }

  let(:game_rules) { GameRules.new(board) }
  let(:game_options) { { :board => board, :ai => ai, :io => mock_io, :menu => menu, :game_rules => game_rules } }
  let(:game) { Game.new(game_options) }

  it 'creates a set of players' do
    allow(menu).to receive(:get_player_name).and_return('fake_name')
    allow(menu).to receive(:get_player_token).and_return('fake_token')
    allow(menu).to receive(:get_player_type).and_return(1, 2)
    game.set_players

    expect(game.players.length).to eq(2)
  end

  context "make move" do
    it "makes a move for a human" do
      game.players = [player_1, player_2]
      game.set_current_player
      allow(player_1).to receive(:make_move).and_return(1)
      game.make_move

      expect(board.cells).to eq([  "E", nil, nil,
                                   nil, nil, nil,
                                   nil, nil, nil ])
    end

    it 'toggles current player after each move' do
      game.players = [player_1, player_2]
      game.set_current_player
      allow(player_1).to receive(:make_move).and_return(1)

      expect(game.current_player).to eq(player_1)
      game.make_move
      expect(game.current_player).to eq(player_2)
    end
  end

  context "make move - testing valid input" do
    it "doesn't let you enter a number < 1" do
      game.players = [player_1, player_2]
      game.set_current_player
      allow(player_1).to receive(:make_move).and_return(-1, 1)
      game.make_move

      expect(board.cells).to eq([  "E", nil, nil,
                                   nil, nil, nil,
                                   nil, nil, nil ])
    end

    it "doesn't let you enter a number > 9" do
      game.players = [player_1, player_2]
      game.set_current_player
      allow(player_1).to receive(:make_move).and_return(10, 1)
      game.make_move

      expect(board.cells).to eq([  "E", nil, nil,
                                   nil, nil, nil,
                                   nil, nil, nil ])
    end

    it "doesn't let you enter a string" do
      game.players = [player_1, player_2]
      game.set_current_player
      allow(player_1).to receive(:make_move).and_return('apple', 1)
      game.make_move

      expect(board.cells).to eq([  "E", nil, nil,
                                   nil, nil, nil,
                                   nil, nil, nil ])
    end

    it "tells you when your input is invalid" do
      game.players = [player_1, player_2]
      game.set_current_player
      allow(player_1).to receive(:make_move).and_return('apple', 1)
      game.make_move

      expect(mock_io.printed_strings.include?("That is invalid input.  Please choose open spaces 1 to 9.")).to eq(true)
    end

    it "keeps prompting human for input until valid" do
      game.players = [player_1, player_2]
      game.set_current_player
      allow(mock_io).to receive(:input).and_return(-1, 123, 'apple', 5)
      game.make_move

      expect(board.cells).to eq([  nil, nil, nil,
                                   nil, "E", nil,
                                   nil, nil, nil ])
      expect(mock_io.printed_strings.include?("That is invalid input.  Please choose open spaces 1 to 9.")).to eq(true)
    end
  end

  context "make move - testing valid cell" do
    it "does not let you enter a token in a non-valid cell" do
      game.players = [player_1, player_2]
      game.set_current_player
      board.fill_cell(1, player_1.token)
      allow(player_1).to receive(:make_move).and_return(1, 2)
      game.make_move

      expect(board.cells).to eq(["E", "E", nil,
                                 nil, nil, nil,
                                 nil, nil, nil])
    end

    it "tells you that a cell is invalid" do
      game.players = [player_1, player_2]
      game.set_current_player
      board.fill_cell(1, player_2.token)
      allow(player_1).to receive(:make_move).and_return(1, 2)
      game.make_move

      expect(mock_io.printed_strings.include?("That spot is already taken.  Please choose an empty spot.")).to eq(true)
    end

    it "keeps prompting human player until a valid cell move is made" do
      game.players = [player_1, player_2]
      game.set_current_player
      board.cells = ["E", "V", "E",
                     "V", nil, nil,
                     nil, nil, nil ]
      allow(player_1).to receive(:make_move).and_return(1, 2, 3, 4, 5)
      game.make_move

      expect(board.cells).to eq( ["E", "V", "E",
                                  "V", "E", nil,
                                  nil, nil, nil ])
    end
  end

  context "ai turn" do
    it "ai gets random move, sends correct message, and fills the board" do
      game.current_player = player_2
      allow(player_2).to receive(:make_move).and_return(5)
      game.make_move

      expect(mock_io.printed_strings[0]).to match /Vivian made the move: 5/
      expect(mock_io.printed_strings[1]).to eq(mock_io.display_board_message)

      expect(board.cells[4]).to eq(player_2.token)
    end
  end

  context "set winner: " do
    it "sets the winner of the game" do
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

  context 'asks the player(s) if want(s) to play the game again' do
    it 'resets the board if player(s) want(s) to play again' do
      board.cells = [ "E", "E", "V",
                      "V", "V", "E",
                      "E", "E", "V" ]
      allow(mock_io).to receive(:input).and_return('y')
      game.ask_to_play_again

      expect(board.cells).to eq([ nil, nil, nil,
                                  nil, nil, nil,
                                  nil, nil, nil ])
    end

    it 'if player(s) respond(s) no to play again, exits out of the game loop' do
      allow(mock_io).to receive(:input).and_return('n')
      game.ask_to_play_again

      expect(game.play_again).to eq(false)
    end
  end

end
