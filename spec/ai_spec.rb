require './lib/board'
require './lib/ai'

describe Ai do

  let(:board) { Board.new(3, 9) }
  let(:ai) { Ai.new(board.cells) }

  it "finds a random move" do
    (1..board.size**2).include?(ai.find_move).should == true
  end

end
