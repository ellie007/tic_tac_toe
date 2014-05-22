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
  let(:player_2) { AiPlayer.new("Vivian", "V", ai, mock_io) }
  let(:game_rules) { GameRules.new(board) }
  let(:game) { Game.new(board, ai, mock_io, menu, [player_1, player_2], game_rules) }

  context "make move: " do
    it "makes a move for a human" do
      allow(player_1).to receive(:make_move).and_return(1)
      game.make_move

      expect(board.cells).to eq([ "E", nil, nil,
                                   nil, nil, nil,
                                   nil, nil, nil ])
    end

    it "keeps prompting human for input until valid input" do
      allow(mock_io).to receive(:prompt_for_input).and_return(123, 'apple', 5)
      game.make_move

      expect(mock_io.printed_strings[0]).to match /That is invalid input./
      expect(mock_io.printed_strings[1]).to eq(mock_io.display_board_message)
      expect(mock_io.printed_strings[2]).to match /That is invalid input./
      expect(mock_io.printed_strings[3]).to eq(mock_io.display_board_message)
      expect(mock_io.printed_strings[4]).to eq(mock_io.display_board_message)

      expect(board.cells[4]).to eq(player_1.token)
    end

    it "keeps prompting human for input until valid cell" do
      board.cells = [ "X", nil, nil,
                      nil, nil, nil,
                      nil, nil, nil ]

      allow(mock_io).to receive(:prompt_for_input).and_return(1,2)
      game.make_move

      expect(board.cells[1]).to eq(player_1.token)
      expect(mock_io.printed_strings[0]).to match /That spot is already taken./
      expect(mock_io.printed_strings[1]).to eq(mock_io.display_board_message)
      expect(mock_io.printed_strings[2]).to eq(mock_io.display_board_message)
    end
  end

  context "ai turn" do
    it "ai gets random move, sends correct message, and fills the board" do
      game.current_player = player_2
      #ai.stub find_move: 5
      allow(game.current_player).to receive(:make_move).and_return(5)
      game.make_move

      expect(mock_io.printed_strings[0]).to eq(mock_io.display_board_message)
      expect(board.cells[4]).to eq(game.current_player.token)
    end
  end

  it 'toggles the current player' do
    game.current_player = player_2
    game.toggle_current_player

    expect(game.current_player).to eq(player_1)
  end

  context "set winner: " do
    it "winner instance variable set with set_winner" do
      board.cells = [ "E", nil, nil,
                      nil, "E", nil,
                      nil, nil, "E" ]
      game.winner_display

      game.winner.should == player_1.token
    end
  end

  context 'winner_display: ' do
    it "displays the winner of the game when there is a winner" do
      board.cells = [ "E", "E", "E",
                      nil, nil, nil,
                      nil, nil, nil ]

      game.winner_display

      expect(mock_io.printed_strings[0]).to eq(mock_io.display_board_message)
      expect(mock_io.printed_strings[1]).to match /eleanor won!/i
    end

    it 'displays it was a tie game' do
      board.cells = [ "E", "E", "V",
                      "V", "V", "E",
                      "E", "E", "V" ]

      game.winner_display

      expect(mock_io.printed_strings[1]).to match /tie game/
    end
  end

end
