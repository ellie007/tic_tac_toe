require 'game'
require 'board'
require 'ai'
require 'player'
require 'mock_output'

describe Game do

  let(:menu) { Menu.new }
  let(:board) { Board.new(3) }
  let(:ai) { Ai.new(board.cells) }
  let(:player_1) { Player.new }
  let(:player_2) { Player.new }
  let(:mock_io) { MockCommandLine.new(board.cells, ai) }
  let(:game) { Game.new(board, ai, mock_io, menu, player_1, player_2) }

  context 'run' do
    it 'prints the welcome message and displays the board' do #, t:true do
      allow(mock_io).to receive(:game_loop)
      #game.winner = ai.token
      game.run

      expect(mock_io.printed_strings[0]).to match /welcome to tic tac toe/i
      expect(mock_io.printed_strings[1]).to eq(mock_io.display_board_message)
    end

    it 'displays that watson is the winner of the game if watson wins' do
      allow(mock_io).to receive(:game_loop)
      game.winner = ai.token
      game.run1

      expect(mock_io.printed_strings[2]).to match /watson won/i
    end

    it 'displays that player is the winner of the game if player wins' do
      allow(mock_io).to receive(:game_loop)
      game.winner = player.token
      game.run

      expect(mock_io.printed_strings[2]).to match /you won/i
    end

    it 'displays that it was a tie game' do
      game.stub(:game_loop)

      board.fill_cell(1, player.token)
      board.fill_cell(2, player.token)
      board.fill_cell(3, ai.token)
      board.fill_cell(4, ai.token)
      board.fill_cell(5, ai.token)
      board.fill_cell(6, player.token)
      board.fill_cell(7, player.token)
      board.fill_cell(8, ai.token)
      board.fill_cell(9, player.token)

      game.run1

      expect(mock_io.printed_strings[2]).to match /tie game/
    end
  end

  context "human turn" do
    it "keeps prompting human for input until valid input" do
      allow(mock_io).to receive(:player_input).and_return(123, 'a', 5)
      game.human_turn

      expect(mock_io.printed_strings[0]).to match /That is invalid input./
      expect(mock_io.printed_strings[1]).to eq(mock_io.display_board_message)
      expect(mock_io.printed_strings[2]).to match /That is invalid input./
      expect(mock_io.printed_strings[3]).to eq(mock_io.display_board_message)
      expect(mock_io.printed_strings[4]).to eq(mock_io.display_board_message)

      expect(board.cells[4]).to eq(player.token)
    end

    it "keeps prompting human for input until valid cell" do
      board.fill_cell(1, player.token)
      allow(mock_io).to receive(:player_input).and_return(1,2)
      game.human_turn

      expect(board.cells[1]).to eq(player.token)
      expect(mock_io.printed_strings[0]).to match /That spot is already taken./
      expect(mock_io.printed_strings[1]).to eq(mock_io.display_board_message)
      expect(mock_io.printed_strings[2]).to eq(mock_io.display_board_message)
    end
  end

  context "ai turn" do
    it "makes an ai move sends that message to the correct flow control" do
      allow(mock_io).to receive(:find_move) { 2 }
      allow(board).to receive(:fill_cell)
      game.ai_turn

      expect(board).to have_received(:fill_cell)
      expect(mock_io.printed_strings[0]).to match /watson's turn/i
      expect(mock_io.printed_strings[1]).to eq(mock_io.display_board_message)
    end
  end

  context "calculates sum" do
    it "adds one for an ai token" do
      cell = ai.token
      game.sum = 0
      game.calculate_sum(cell)
      game.sum.should == 1
    end
    it "subtracts one for an player token" do
      cell = player.token
      game.sum = 0
      game.calculate_sum(cell)
      game.sum.should == -1
    end
  end

  context "correctly sets the winner based on sum" do
    it "the winner is set with the ai token" do
      game.sum = 3
      game.set_winner.should == ai.token
    end

    it "the winner is set with the player token" do
      game.sum = -3
      game.set_winner.should == player.token
    end
  end

  context "game winner determination:" do
    it "has no winner at the beginning of the game" do
      game.winner?.should == nil
    end

    it "ai wins the game with a principal diagonal" do
      board.fill_cell(1, ai.token)
      board.fill_cell(5, ai.token)
      board.fill_cell(9, ai.token)

      game.winner?.should == ai.token
    end

    it "ai wins the game with a row" do
      board.fill_cell(1, ai.token)
      board.fill_cell(2, ai.token)
      board.fill_cell(3, ai.token)

      game.winner?.should == ai.token
    end

    it "ai wins the game with a column" do
      board.fill_cell(1, ai.token)
      board.fill_cell(4, ai.token)
      board.fill_cell(7, ai.token)

      game.winner?.should == ai.token
    end

    it "player wins the game with a counter diagonal" do
      board.fill_cell(3, player.token)
      board.fill_cell(5, player.token)
      board.fill_cell(7, player.token)

      game.winner?.should == player.token
    end

    it "player wins the game with a row" do
      board.fill_cell(4, player.token)
      board.fill_cell(5, player.token)
      board.fill_cell(6, player.token)

      game.winner?.should == player.token
    end

    it "player wins the game with a column" do
      board.fill_cell(2, player.token)
      board.fill_cell(5, player.token)
      board.fill_cell(8, player.token)

      game.winner?.should == player.token
    end

    it "is a tie game" do
      board.fill_cell(1, player.token)
      board.fill_cell(2, player.token)
      board.fill_cell(3, ai.token)
      board.fill_cell(4, ai.token)
      board.fill_cell(5, ai.token)
      board.fill_cell(6, player.token)
      board.fill_cell(7, player.token)
      board.fill_cell(8, ai.token)
      board.fill_cell(9, player.token)

      game.is_tie?.should == true
    end
  end

  context "player input validation" do
    it "should return a false value for an invalid input type" do
      game.valid_input?('123').should == false
    end

    it "should not allow the player to place in a taken cell" do
      board.fill_cell(5, player.token)
      game.valid_cell?(5).should == false
    end

    it "should allow the player to place in an empty cell" do
      game.valid_cell?(5).should == true
    end
  end

  context "determines whether the game is over or not" do
    it "game over is true with tie game" do
      board.fill_cell(1, player.token)
      board.fill_cell(2, player.token)
      board.fill_cell(3, ai.token)
      board.fill_cell(4, ai.token)
      board.fill_cell(5, ai.token)
      board.fill_cell(6, player.token)
      board.fill_cell(7, player.token)
      board.fill_cell(8, ai.token)
      board.fill_cell(9, player.token)

      game.game_over.should == true
    end

    it "game over is true with a winner" do
      game.winner = player.token
      game.game_over == true
    end

    it "game is not over with no winner" do
      game.winner = nil
      game.game_over == false
    end

    it "game is not over mid game" do
      board.fill_cell(1, player.token)
      board.fill_cell(5, ai.token)
      game.game_over == false
    end
  end

end



