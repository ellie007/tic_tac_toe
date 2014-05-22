require 'game'
require 'board'
require 'ai'
require 'human_player'
require 'menu'
require 'game_rules'
require_relative 'mock_command_line'

describe Game do

  let(:mock_io) { MockCommandLine.new }
  let(:menu) { Menu.new(mock_io) }
  let(:board) { Board.new(3) }
  let(:ai) { Ai.new(board.cells) }
  let(:player_1) { HumanPlayer.new("Eleanor", "E", mock_io) }
  let(:player_2) { HumanPlayer.new("Vivian", "V", mock_io) }
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
      allow(ai).to receive(:find_move).and_return(5)
      game.ai_turn

      expect(mock_io.printed_strings[0]).to match /Vivian's turn: 5/i
      expect(mock_io.printed_strings[1]).to eq(mock_io.display_board_message)
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

      game.set_winner.should == player_1.token
    end
  end

  # context "player input validation" do
  #   it "should correctly determine if invalid input type" do
  #     game.valid_input?('apple').should == false
  #     game.valid_input?(0).should == false
  #     game.valid_input?(10).should == false
  #     game.valid_input?(5).should == true
  #   end

  #   it "should not allow the player to place in a taken cell" do
  #     board.cells = [ nil, nil, nil,
  #                     nil, "E", nil,
  #                     nil, nil, nil ]

  #     game.valid_cell?(5).should == false
  #   end

  #   it "should allow the player to place in an empty cell" do
  #     game.valid_cell?(5).should == true
  #   end
  # end

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
