require 'game'
require 'board'

describe Game do

  let(:board) { Board.new }
  let(:ai)    { Ai.new([]) }
  let(:game)  { Game.new(board, {}, {}) }

  it "has no winner at the beginning of the game" do
    game.winner.should == nil
  end

  it "the ai wins the game with a diagonal" do
  end

  it "the ai wins the game with a row" do
    # make board with three O's in a row
    # make sure that ai is the winner
    board.fill_cell(1, ai.ai_sign)
    board.fill_cell(2, ai.ai_sign)
    board.fill_cell(3, ai.ai_sign)

    game.winner.should == ai.ai_sign
  end


  it "the ai wins the game with a column" do
  end

end


