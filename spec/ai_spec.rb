require './lib/board'
require './lib/ai'

describe Ai do

  let(:board) { Board.new(3) }
  let(:ai) { Ai.new(board.cells) }

  it "finds a random move" do
    (board.size**2).include?(ai.find_move).should == true
  end

end
