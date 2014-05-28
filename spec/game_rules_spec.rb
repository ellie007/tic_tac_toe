require 'game_rules'
require 'human_player'
require 'board'

describe GameRules do

  let(:board) { Board.new(3) }
  let(:player_1) { Player.new("Eleanor", "E", "human") }
  let(:player_2) { Player.new("Vivian", "V", "human") }
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
