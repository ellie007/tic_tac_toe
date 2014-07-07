require 'board'
require 'game_rules'

describe GameRules, "2D board" do

  let(:board) { Board.new }
  let(:game_rules) { GameRules }

  context 'is tie?:' do
    it "determines if a tie game" do
      winner = nil
      board.cells = [ "E", "E", "V",
                      "V", "V", "E",
                      "E", "E", "V" ]

      expect(game_rules.game_over?(board)).to eq(true)
    end
  end

  context "game winner determination:" do
    it "has no winner at the beginning of the game" do
      expect(game_rules.game_over?(board)).to eq(false)
    end

    it "player wins the game with a row" do
      board.cells = [ "E", "E", "E",
                      nil, nil, nil,
                      nil, nil, nil ]

      expect(game_rules.game_over?(board)).to eq(true)
    end

    it "player wins the game with a column" do
      board.cells = [ "E", nil, nil,
                      "E", nil, nil,
                      "E", nil, nil ]

      expect(game_rules.game_over?(board)).to eq(true)
    end

    it "player wins the game with a principal diagonal" do
      board.cells = [ "E", nil, nil,
                      nil, "E", nil,
                      nil, nil, "E" ]

      expect(game_rules.game_over?(board)).to eq(true)
    end

    it "player wins the game with a counter diagonal" do
      board.cells = [ nil, nil, "E",
                      nil, "E", nil,
                      "E", nil, nil ]

      expect(game_rules.game_over?(board)).to eq(true)
    end
  end

  context 'game over:' do
    it "determines game is over with tie game" do
      board.cells = [ "E", "E", "V",
                      "V", "V", "E",
                      "E", "E", "V" ]

      expect(game_rules.game_over?(board)).to eq(true)
    end

    it "determines game is over with a winner" do
      board.cells = [ "E", "E", "E",
                        nil, nil, nil,
                        nil, nil, nil ]

      expect(game_rules.game_over?(board)).to eq(true)
    end

    it "game is not over with no winner" do
      expect(game_rules.game_over?(board)).to eq(false)
    end

    it "game is not over mid game" do
      board.cells = [ "E", "E", nil,
                      nil, "V", nil,
                      nil, nil, nil ]

      expect(game_rules.game_over?(board)).to eq(false)
    end
  end

end


describe GameRules, "3D board" do

  let(:board) { Board.new(3, 3) }
  let(:game_rules) { GameRules }

  context "x axis winner" do
    it "player wins the game with a row" do
      board.cells = [ nil, nil, nil,
                      nil, nil, nil,
                      nil, nil, nil,

                      "E", "E", "E",
                      nil, nil, nil,
                      nil, nil, nil,

                      nil, nil, nil,
                      nil, nil, nil,
                      nil, nil, nil ]

      expect(game_rules.game_over?(board)).to eq(true)
    end

    it "player wins the game with a column" do
      board.cells = [ nil, nil, nil,
                      nil, nil, nil,
                      nil, nil, nil,

                      nil, nil, nil,
                      nil, nil, nil,
                      nil, nil, nil,

                      nil, "E", nil,
                      nil, "E", nil,
                      nil, "E", nil ]

      expect(game_rules.game_over?(board)).to eq(true)
    end

    it "player wins the game with a principal diagonal" do
      board.cells = [ nil, nil, nil,
                      nil, nil, nil,
                      nil, nil, nil,

                      "E", nil, nil,
                      nil, "E", nil,
                      nil, nil, "E",

                      nil, nil, nil,
                      nil, nil, nil,
                      nil, nil, nil ]

      expect(game_rules.game_over?(board)).to eq(true)
    end

    it "player wins the game with a counter diagonal" do
      board.cells = [ nil, nil, nil,
                      nil, nil, nil,
                      nil, nil, nil,

                      nil, nil, nil,
                      nil, nil, nil,
                      nil, nil, nil,

                      nil, nil, "E",
                      nil, "E", nil,
                      "E", nil, nil ]

      expect(game_rules.game_over?(board)).to eq(true)
    end
  end

   context "z axis winner" do
    it "player wins the game with a row" do
      board.cells = [ "E", nil, nil,
                      nil, nil, nil,
                      nil, nil, nil,

                      "E", nil, nil,
                      nil, nil, nil,
                      nil, nil, nil,

                      "E", nil, nil,
                      nil, nil, nil,
                      nil, nil, nil ]

      expect(game_rules.game_over?(board)).to eq(true)
    end

    it "player wins the game with a column" do
      board.cells = [ nil, nil, nil,
                      nil, nil, nil,
                      nil, nil, nil,

                      "E", nil, nil,
                      "E", nil, nil,
                      "E", nil, nil,

                      nil, nil, nil,
                      nil, nil, nil,
                      nil, nil, nil ]

      expect(game_rules.game_over?(board)).to eq(true)
    end

    it "player wins the game with a principal diagonal" do
      board.cells = [ "E", nil, nil,
                      nil, nil, nil,
                      nil, nil, nil,

                      nil, nil, nil,
                      "E", nil, nil,
                      nil, nil, nil,

                      nil, nil, nil,
                      nil, nil, nil,
                      "E", nil, nil ]

      expect(game_rules.game_over?(board)).to eq(true)
    end

    it "player wins the game with a counter diagonal" do
      board.cells = [ nil, nil, nil,
                      nil, nil, nil,
                      "E", nil, nil,

                      nil, nil, nil,
                      "E", nil, nil,
                      nil, nil, nil,

                      "E", nil, nil,
                      nil, nil, nil,
                      nil, nil, nil ]

      expect(game_rules.game_over?(board)).to eq(true)
    end
  end

   context "y axis winner" do
    it "player wins the game with a row" do
      board.cells = [ nil, nil, nil,
                      nil, nil, nil,
                      nil, nil, nil,

                      nil, nil, nil,
                      nil, nil, nil,
                      nil, nil, nil,

                      "E", "E", "E",
                      nil, nil, nil,
                      nil, nil, nil ]

      expect(game_rules.game_over?(board)).to eq(true)
    end

    it "player wins the game with a column" do
      board.cells = [ "E", nil, nil,
                      nil, nil, nil,
                      nil, nil, nil,

                      "E", nil, nil,
                      nil, nil, nil,
                      nil, nil, nil,

                      "E", nil, nil,
                      nil, nil, nil,
                      nil, nil, nil ]

      expect(game_rules.game_over?(board)).to eq(true)
    end

    it "player wins the game with a principal diagonal" do
      board.cells = [ "E", nil, nil,
                      nil, nil, nil,
                      nil, nil, nil,

                      nil, "E", nil,
                      nil, nil, nil,
                      nil, nil, nil,

                      nil, nil, "E",
                      nil, nil, nil,
                      nil, nil, nil ]

      expect(game_rules.game_over?(board)).to eq(true)
    end

    it "player wins the game with a counter diagonal" do
      board.cells = [ nil, nil, "E",
                      nil, nil, nil,
                      nil, nil, nil,

                      nil, "E", nil,
                      nil, nil, nil,
                      nil, nil, nil,

                      "E", nil, nil,
                      nil, nil, nil,
                      nil, nil, nil ]

      expect(game_rules.game_over?(board)).to eq(true)
    end
  end

  context "3D diagonals" do
    it "player wins game with a 3D diagonal (starting at top left)" do
      board.cells = [ "E", nil, nil,
                      nil, nil, nil,
                      nil, nil, nil,

                      nil, nil, nil,
                      nil, "E", nil,
                      nil, nil, nil,

                      nil, nil, nil,
                      nil, nil, nil,
                      nil, nil, "E" ]

      expect(game_rules.game_over?(board)).to eq(true)
    end

    it "player wins game with a 3D diagonal (starting at top right)" do
      board.cells = [ nil, nil, "E",
                      nil, nil, nil,
                      nil, nil, nil,

                      nil, nil, nil,
                      nil, "E", nil,
                      nil, nil, nil,

                      nil, nil, nil,
                      nil, nil, nil,
                      "E", nil, nil ]

      expect(game_rules.game_over?(board)).to eq(true)
    end

      it "player wins game with a 3D diagonal (starting at bottom left)" do
      board.cells = [ nil, nil, nil,
                      nil, nil, nil,
                      "E", nil, nil,

                      nil, nil, nil,
                      nil, "E", nil,
                      nil, nil, nil,

                      nil, nil, "E",
                      nil, nil, nil,
                      nil, nil, nil ]

      expect(game_rules.game_over?(board)).to eq(true)
    end

      it "player wins game with a 3D diagonal (starting at bottom right)" do
      board.cells = [ nil, nil, nil,
                      nil, nil, nil,
                      nil, nil, "E",

                      nil, nil, nil,
                      nil, "E", nil,
                      nil, nil, nil,

                      "E", nil, nil,
                      nil, nil, nil,
                      nil, nil, nil ]

      expect(game_rules.game_over?(board)).to eq(true)
    end
  end

end
