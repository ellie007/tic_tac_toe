require 'game_rules'
require 'player'
require 'board'

describe GameRules do

  let(:board) { Board.new(3) }
  let(:player_1) { Player.new({},{},{}) }
  let(:player_2) { Player.new({},{},{}) }
  let(:game_rules) { GameRules.new(board) }

  context 'is tie?:' do
    it "is a tie game" do
      player_1.token = "X"
      player_2.token = "O"
      winner = nil
      tie_game

      game_rules.is_tie?.should == true
    end
  end

  context "game winner determination:" do
    it "has no winner at the beginning of the game" do
      game_rules.winner?.should == false
    end

    it "player wins the game with a row" do
      player_1.token = "X"
      board.fill_cell(1, player_1.token)
      board.fill_cell(2, player_1.token)
      board.fill_cell(3, player_1.token)

      game_rules.winner?.should == true
    end

    it "player wins the game with a column" do
      player_1.token = "X"
      board.fill_cell(1, player_1.token)
      board.fill_cell(4, player_1.token)
      board.fill_cell(7, player_1.token)

      game_rules.winner?.should == true
    end

    it "player wins the game with a principal diagonal" do
      player_1.token = "X"
      board.fill_cell(1, player_1.token)
      board.fill_cell(5, player_1.token)
      board.fill_cell(9, player_1.token)

      game_rules.winner?.should == true
    end

    it "player wins the game with a counter diagonal" do
      player_1.token = "X"
      board.fill_cell(3, player_1.token)
      board.fill_cell(5, player_1.token)
      board.fill_cell(7, player_1.token)

      game_rules.winner?.should == true
    end
  end

  context 'game over:' do
    it "true with tie game" do
      player_1.token = "X"
      player_2.token = "O"
      tie_game

      game_rules.game_over.should == true
    end

    it "game over is true with a winner" do
      player_1.token = "X"
      board.fill_cell(1, player_1.token)
      board.fill_cell(2, player_1.token)
      board.fill_cell(3, player_1.token)

      game_rules.game_over.should == true
    end

    it "game is not over with no winner" do
      player_1.token = "X"

      game_rules.game_over.should == false
    end

    it "game is not over mid game" do
      player_1.token = "X"
      player_2.token = "O"
      board.fill_cell(1, player_1.token)
      board.fill_cell(5, player_2.token)

      game_rules.game_over.should == false
    end
  end

end

private

def tie_game
  board.fill_cell(1, player_1.token)
  board.fill_cell(2, player_1.token)
  board.fill_cell(3, player_2.token)
  board.fill_cell(4, player_2.token)
  board.fill_cell(5, player_2.token)
  board.fill_cell(6, player_1.token)
  board.fill_cell(7, player_1.token)
  board.fill_cell(8, player_2.token)
  board.fill_cell(9, player_1.token)
end
