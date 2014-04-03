require 'game'
require 'board'
require 'ai'
require 'player'

describe Game do

  let(:board) { Board.new }
  let(:ai)    { Ai.new(board.cells) }
  let(:player) { Player.new }
  let(:game)  { Game.new(board, ai, player, {}) }


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
      game.is_winner.should == nil
    end

    it "ai wins the game with a diagonal" do
      board.fill_cell(1, ai.token)
      board.fill_cell(5, ai.token)
      board.fill_cell(9, ai.token)

      game.is_winner.should == ai.token
    end
    it "ai wins the game with a row" do
      board.fill_cell(1, ai.token)
      board.fill_cell(2, ai.token)
      board.fill_cell(3, ai.token)

      game.is_winner.should == ai.token
    end
    it "ai wins the game with a column" do
      board.fill_cell(1, ai.token)
      board.fill_cell(4, ai.token)
      board.fill_cell(7, ai.token)

      game.is_winner.should == ai.token
    end

    it "player wins the game with a diagonal" do
      board.fill_cell(1, player.token)
      board.fill_cell(5, player.token)
      board.fill_cell(9, player.token)

      game.is_winner.should == player.token
    end
    it "player wins the game with a row" do
      board.fill_cell(1, player.token)
      board.fill_cell(2, player.token)
      board.fill_cell(3, player.token)

      game.is_winner.should == player.token
    end
    it "player wins the game with a column" do
      board.fill_cell(1, player.token)
      board.fill_cell(4, player.token)
      board.fill_cell(7, player.token)

      game.is_winner.should == player.token
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

  context "determines the game is over or not" do
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



