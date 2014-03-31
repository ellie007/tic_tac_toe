require 'game'
require 'board'
require 'ai'
require 'player'

describe Game do

  let(:board) { Board.new }
  let(:ai)    { Ai.new(board.cells) }
  let(:player) { Player.new }
  let(:game)  { Game.new(board, ai, player) }

  context "placement of moves on the board" do
    it "makes a move for a human" do
      game.human_turn(1).should == [" X ", "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   "]
    end
    it "makes a move for ai" do
      game.ai_turn(2).should == ["   ", " O ", "   ", "   ", "   ", "   ", "   ", "   ", "   "]
    end
  end

  context "game winner determination" do
    it "has no winner at the beginning of the game" do
      game.is_winner.should == nil
    end

    it "the ai wins the game with a diagonal" do
      board.fill_cell(1, ai.token)
      board.fill_cell(5, ai.token)
      board.fill_cell(9, ai.token)

      game.is_winner.should == ai.token
    end
    it "the ai wins the game with a row" do
      board.fill_cell(1, ai.token)
      board.fill_cell(2, ai.token)
      board.fill_cell(3, ai.token)

      game.is_winner.should == ai.token
    end
    it "the ai wins the game with a column" do
      board.fill_cell(1, ai.token)
      board.fill_cell(4, ai.token)
      board.fill_cell(7, ai.token)

      game.is_winner.should == ai.token
    end

    it "the player wins the game with a diagonal" do
      board.fill_cell(1, player.token)
      board.fill_cell(5, player.token)
      board.fill_cell(9, player.token)

      game.is_winner.should == player.token
    end
    it "the player wins the game with a row" do
      board.fill_cell(1, player.token)
      board.fill_cell(2, player.token)
      board.fill_cell(3, player.token)

      game.is_winner.should == player.token
    end
    it "the player wins the game with a column" do
      board.fill_cell(1, player.token)
      board.fill_cell(4, player.token)
      board.fill_cell(7, player.token)

      game.is_winner.should == player.token
    end
  end

  context "player input validation" do
    it "should return a false value for an invalid input type" do
      game.valid_input?('123').should == false
    end
    it "should not allow the player to place in a taken cell" do
      board.fill_cell(5, player.token)
      game.valid_cell?(5).should == true
    end
    it "should allow the player to place in an empty cell" do
      game.valid_cell?(5).should == false
    end
  end

end



