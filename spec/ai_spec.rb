require './lib/board'
require './lib/ai'


describe Ai do

  let(:ai) { Ai.new(board.cells) }


  it "find a random move" do
    [1,2,3,4,5,6,7,8,9].include?(ai.find_move).should == true

    #expect([1,2,3,4,5,6,7,8,9].include?(move)).to eq(true)
  end

end
