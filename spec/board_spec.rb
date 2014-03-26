require 'board'

describe Board do

  let(:board) { Board.new }

  it "places a move for the player on the board" do
    board.fill_cell(4," X ").should == ["   ","   ","   "," X ","   ","   ","   ","   ","   "]
  end
  it "places a move for the computer on the board" do
    board.fill_cell(1," O ").should == [" O ","   ","   ","   ","   ","   ","   ","   ","   "]
  end

end
