require 'ai_player'
require 'board'
require 'easy_ai'
require 'game'
require 'hard_ai'
require 'human_player'
require 'custom_menu'
require 'player_factory'
require_relative 'mock_command_line'

describe Game do

  let(:mock_io) { MockCommandLine.new }
  let(:menu) { CustomMenu.new(mock_io) }
  let(:board) { Board.new }
  let(:hard_ai) { HardAi.new }
  let(:easy_ai) { EasyAi.new }

  let(:player_1) { HumanPlayer.new(mock_io) }
  let(:player_2) { AiPlayer.new(hard_ai) }

  before(:each) do
    player_1.name = 'Eleanor'
    player_1.token = 'E'
    player_2.name = 'Vivian'
    player_2.token = 'V'
  end

  let(:player_factory) { PlayerFactory.new(easy_ai, hard_ai, mock_io) }

  let(:game_options) { { :board => board, :io => mock_io, :menu => menu, :player_factory => player_factory } }
  let(:game) { Game.new(game_options) }

  it 'creates a set of players' do
    allow(menu).to receive(:get_number_of_players).and_return(2)
    allow(mock_io).to receive(:input).and_return('fake_name_1', 'X', 1,'fake_name_2', 'O', 2, 2)
    game.set_players

    expect(game.players.length).to eq(2)
  end

  context "make move" do
    it "makes a move for a human" do
      game.players = [player_1, player_2]
      game.set_current_and_opponent_player
      allow(game.current_player).to receive(:make_move).and_return(1)
      game.make_move

      expect(board.cells).to eq([  nil, "E", nil,
                                   nil, nil, nil,
                                   nil, nil, nil ])
    end

    it 'toggles current player after each move' do
      game.players = [player_1, player_2]
      game.set_current_and_opponent_player
      allow(game.current_player).to receive(:make_move).and_return(1)

      expect(game.current_player).to eq(player_1)
      game.make_move
      expect(game.current_player).to eq(player_2)
    end

    it 'toggles opponent player after each move' do
      game.players = [player_1, player_2]
      game.set_current_and_opponent_player
      allow(game.current_player).to receive(:make_move).and_return(1)

      expect(game.opponent_player).to eq(player_2)
      game.make_move
      expect(game.opponent_player).to eq(player_1)
    end
  end

  context "other input options for human player: " do
    it "restarts the game with same options" do
      game.players = [player_1, player_2]
      game.set_current_and_opponent_player
      board.cells = [ "E", nil, "V",
                      nil, "E", nil,
                      "V", nil, nil ]
      allow(game.current_player).to receive(:make_move).and_return('restart')
      game.make_move

      expect(board.cells).to eq([ nil, nil, nil,
                                  nil, nil, nil,
                                  nil, nil, nil ])
      expect(game.current_player).to eq(player_1)
    end

    it "resets menu options and starts new game with those options" do
      game.players = [player_1, player_2]
      game.set_current_and_opponent_player
      allow(game.current_player).to receive(:make_move).and_return('menu')
      game.stub(:start_new_game)
      game.make_move

      expect(game).to have_received(:start_new_game)
    end
  end

  context "human make move - testing valid input - " do
    it "doesn't let you enter a number < 0" do
      game.players = [player_1, player_2]
      game.set_current_and_opponent_player
      allow(game.current_player).to receive(:make_move).and_return(-1, 1)
      game.make_move

      expect(board.cells).to eq([  nil, "E", nil,
                                   nil, nil, nil,
                                   nil, nil, nil ])
    end

    it "doesn't let you enter a number > 8" do
      game.players = [player_1, player_2]
      game.set_current_and_opponent_player
      allow(game.current_player).to receive(:make_move).and_return(9, 1)
      game.make_move

      expect(board.cells).to eq([  nil, "E", nil,
                                   nil, nil, nil,
                                   nil, nil, nil ])
    end

    it "doesn't let you enter a string" do
      game.players = [player_1, player_2]
      game.set_current_and_opponent_player

      allow(game.current_player).to receive(:make_move).and_return('apple', 2)
      game.make_move

      expect(board.cells).to eq([  nil, nil, "E",
                                   nil, nil, nil,
                                   nil, nil, nil ])
    end

    it "tells you when your input is invalid" do
      game.players = [player_1, player_2]
      game.set_current_and_opponent_player
      allow(game.current_player).to receive(:make_move).and_return('apple', 1)
      game.make_move

      expect(mock_io.printed_strings.include?("That is invalid input.  Please choose open spaces 0 to 8.")).to eq(true)
    end

    it "keeps prompting human for input until valid" do
      game.players = [player_1, player_2]
      game.set_current_and_opponent_player
      allow(mock_io).to receive(:input).and_return(-1, 123, 'apple', 4)
      game.make_move

      expect(board.cells).to eq([  nil, nil, nil,
                                   nil, "E", nil,
                                   nil, nil, nil ])
      expect(mock_io.printed_strings.include?("That is invalid input.  Please choose open spaces 0 to 8.")).to eq(true)
    end
  end

  context "human make move - testing valid cell - " do
    it "does not let you enter a token in a non-valid cell" do
      board.fill_cell(1, player_2.token)
      game.players = [player_1, player_2]
      game.set_current_and_opponent_player
      allow(game.current_player).to receive(:make_move).and_return(1, 0)
      game.make_move

      expect(board.cells).to eq(["E", "V", nil,
                                 nil, nil, nil,
                                 nil, nil, nil])
    end

    it "tells you that a cell is invalid" do
      board.fill_cell(1, player_2.token)
      game.players = [player_1, player_2]
      game.set_current_and_opponent_player
      allow(game.current_player).to receive(:make_move).and_return(1, 2)
      game.make_move

      expect(mock_io.printed_strings.include?("That spot is already taken.  Please choose an empty spot.")).to eq(true)
    end

    it "keeps prompting human player until a valid cell move is made" do
      game.players = [player_1, player_2]
      game.set_current_and_opponent_player
      board.cells = ["E", "V", "E",
                     "V", nil, nil,
                     nil, nil, nil ]
      allow(game.current_player).to receive(:make_move).and_return(0, 1, 2, 3, 4)
      game.make_move

      expect(board.cells).to eq( ["E", "V", "E",
                                  "V", "E", nil,
                                  nil, nil, nil ])
    end
  end

  context "ai make move - " do
    it "uses minimax to find the best move and correctly fills the board" do
      game.players = [player_1, player_2]
      game.current_player = player_2
      game.opponent_player = player_1
      game.make_move

      expect(board.cells).to eq([ "V", nil, nil,
                                  nil, nil, nil,
                                  nil, nil, nil ] )
    end

    it "sends the correct display memo" do
      game.players = [player_1, player_2]
      game.current_player = player_2
      game.opponent_player = player_1
      game.make_move

      expect(mock_io.printed_strings[0]).to match /Vivian made the move: 0/
      expect(mock_io.printed_strings[1]).to eq(mock_io.display_board_message)
    end
  end

  context "set winner: " do
    it "sets the winner of the game" do
      game.players = [player_1, player_2]
      game.set_current_and_opponent_player
      board.cells = [ "E", nil, nil,
                      nil, "E", nil,
                      nil, nil, "E" ]
      game.display_winner_information

      expect(game.winner).to eq(player_1.token)
    end
  end

  context 'winner_display: ' do
    it "displays the memo of winner of the game when there is a winner" do
      game.players = [player_1, player_2]
      game.set_current_and_opponent_player
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

