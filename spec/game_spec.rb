require 'game'
require 'board'
require 'ai'
require 'player'
require 'menu'
require 'game_rules'
require_relative 'mock_commandline'

describe Game do

  let(:mock_io) { MockCommandLine.new }
  let(:menu) { Menu.new(mock_io) }
  let(:board) { Board.new(3) }
  let(:ai) { Ai.new(board.cells) }
  let(:player_1) { Player.new("Eleanor", "E", "human") }
  let(:player_2) { Player.new("Vivian", "V", "ai") }
  let(:game_rules) { GameRules.new(board) }
  let(:game) { Game.new(board, ai, mock_io, menu, [player_1, player_2], game_rules) }

  context "human turn" do
    it "keeps prompting human for input until valid input" do
      allow(mock_io).to receive(:player_input).and_return(123, 'a', 5)
      game.human_turn

      expect(mock_io.printed_strings[0]).to match /That is invalid input./
      expect(mock_io.printed_strings[1]).to eq(mock_io.display_board_message)
      expect(mock_io.printed_strings[2]).to match /That is invalid input./
      expect(mock_io.printed_strings[3]).to eq(mock_io.display_board_message)
      expect(mock_io.printed_strings[4]).to eq(mock_io.display_board_message)

      expect(board.cells[4]).to eq(player_1.token)
    end

    it "keeps prompting human for input until valid cell" do
      board.fill_cell(1, player_1.token)
      allow(mock_io).to receive(:player_input).and_return(1,2)
      game.human_turn

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

  context "set winner: " do
    it "winner instance variable set with set_winner" do
      board.fill_cell(1, player_1.token)
      board.fill_cell(5, player_1.token)
      board.fill_cell(9, player_1.token)

      game.set_winner.should == player_1.token
    end
  end

  context "player input validation" do
    it "should correctly determine if invalid input type" do
      game.valid_input?('apple').should == false
      game.valid_input?(0).should == false
      game.valid_input?(10).should == false
      game.valid_input?(5).should == true
    end

    it "should not allow the player to place in a taken cell" do
      board.fill_cell(5, player_1.token)
      game.valid_cell?(5).should == false
    end

    it "should allow the player to place in an empty cell" do
      game.valid_cell?(5).should == true
    end
  end

  context 'winner_display: ' do
    it "displays the winner of the game when there is a winner" do
      board.fill_cell(1, player_1.token)
      board.fill_cell(2, player_1.token)
      board.fill_cell(3, player_1.token)
      game.winner_display

      expect(mock_io.printed_strings[0]).to eq(mock_io.display_board_message)
      expect(mock_io.printed_strings[1]).to match /eleanor won!/i
    end

    it 'displays it was a tie game' do
      board.fill_cell(1, player_1.token)
      board.fill_cell(2, player_1.token)
      board.fill_cell(3, player_2.token)
      board.fill_cell(4, player_2.token)
      board.fill_cell(5, player_2.token)
      board.fill_cell(6, player_1.token)
      board.fill_cell(7, player_1.token)
      board.fill_cell(8, player_2.token)
      board.fill_cell(9, player_1.token)

      game.winner_display

      expect(mock_io.printed_strings[1]).to match /tie game/
    end
  end

end
