require 'game_rules'
require 'board'

describe GameRules, "2D board" do

  let(:board) { Board.new }
  let(:game_rules) { GameRules.new(board) }

  context 'is tie?:' do
    it "determines if a tie game" do
      winner = nil
      board.cells = [ "E", "E", "V",
                      "V", "V", "E",
                      "E", "E", "V" ]

      game_rules.is_tie?.should == true
    end
  end

  context "game winner determination:" do
    it "has no winner at the beginning of the game" do
      # board.cells = [ 0, 1, 2,
      #                 3, 4, 5,
      #                 6, 7, 8 ]

      game_rules.winner?.should == false
    end

    it "player wins the game with a row" do
      board.cells = [ "E", "E", "E",
                      nil, nil, nil,
                      nil, nil, nil ]

      game_rules.winner?.should == true
    end

    it "player wins the game with a column" do
      board.cells = [ "E", nil, nil,
                      "E", nil, nil,
                      "E", nil, nil ]

      game_rules.winner?.should == true
    end

    it "player wins the game with a principal diagonal" do
      board.cells = [ "E", nil, nil,
                      nil, "E", nil,
                      nil, nil, "E" ]

      game_rules.winner?.should == true
    end

    it "player wins the game with a counter diagonal" do
      board.cells = [ nil, nil, "E",
                      nil, "E", nil,
                      "E", nil, nil ]

      game_rules.winner?.should == true
    end
  end

  context 'game over:' do
    it "determines game is over with tie game" do
      board.cells = [ "E", "E", "V",
                      "V", "V", "E",
                      "E", "E", "V" ]

      game_rules.game_over?.should == true
    end

    it "determines game is over with a winner" do
      board.cells = [ "E", "E", "E",
                        nil, nil, nil,
                        nil, nil, nil ]

      game_rules.game_over?.should == true
    end

    it "game is not over with no winner" do
      game_rules.game_over?.should == false
    end

    it "game is not over mid game" do
      board.cells = [ "E", "E", nil,
                      nil, "V", nil,
                      nil, nil, nil ]

      game_rules.game_over?.should == false
    end
  end

end

describe GameRules, "3D board" do

  let(:board) { Board.new(3, 3) }
  let(:game_rules) { GameRules.new(board) }

  context "x axis winner" do
    it "player wins the game with a row" do
      board.fill_cell(10, "E")
      board.fill_cell(11, "E")
      board.fill_cell(12, "E")

      game_rules.winner?.should == true
    end

    it "player wins the game with a column" do
      board.fill_cell(19, "E")
      board.fill_cell(22, "E")
      board.fill_cell(25, "E")

      game_rules.winner?.should == true
    end

    it "player wins the game with a principal diagonal" do
      board.fill_cell(10, "E")
      board.fill_cell(14, "E")
      board.fill_cell(18, "E")

      game_rules.winner?.should == true
    end

    it "player wins the game with a counter diagonal" do
      board.fill_cell(21, "E")
      board.fill_cell(23, "E")
      board.fill_cell(25, "E")

      game_rules.winner?.should == true
    end
  end

   context "z axis winner" do
    it "player wins the game with a row" do
      board.fill_cell(2, "E")
      board.fill_cell(11, "E")
      board.fill_cell(20, "E")
      game_rules.winner?.should == true
    end

    it "player wins the game with a column" do
      board.fill_cell(3, "E")
      board.fill_cell(6, "E")
      board.fill_cell(9, "E")

      game_rules.winner?.should == true
    end

    it "player wins the game with a principal diagonal" do
      board.fill_cell(2, "E")
      board.fill_cell(14, "E")
      board.fill_cell(26, "E")

      game_rules.winner?.should == true
    end

    it "player wins the game with a counter diagonal" do
      board.fill_cell(21, "E")
      board.fill_cell(15, "E")
      board.fill_cell(9, "E")

      game_rules.winner?.should == true
    end
  end

   context "y axis winner" do
    it "player wins the game with a row" do
      board.fill_cell(22, "E")
      board.fill_cell(23, "E")
      board.fill_cell(24, "E")

      game_rules.winner?.should == true
    end

    it "player wins the game with a column" do
      board.fill_cell(25, "E")
      board.fill_cell(16, "E")
      board.fill_cell(7, "E")

      game_rules.winner?.should == true
    end

    it "player wins the game with a principal diagonal" do
      board.fill_cell(22, "E")
      board.fill_cell(14, "E")
      board.fill_cell(6, "E")

      game_rules.winner?.should == true
    end

    it "player wins the game with a counter diagonal" do
      board.fill_cell(27, "E")
      board.fill_cell(17, "E")
      board.fill_cell(7, "E")

      game_rules.winner?.should == true
    end
  end

end
