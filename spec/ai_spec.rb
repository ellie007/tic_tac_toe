require './lib/board'
require './lib/ai'

describe Ai do

  let(:board) { Board.new(3, 2) }
  let(:ai) { Ai.new(board.cells) }

  it "finds a random move" do
    (1..board.size**board.dimension_response).include?(ai.find_move).should == true
  end

end
