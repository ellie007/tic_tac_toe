require 'board'

describe Board do

  let(:board) { Board.new }

  it "places a move for the player on the board" do
    board.fill_cell(4,-1).should == [0, 0, 0, -1, 0, 0, 0, 0, 0]
  end
  it "places a move for the computer on the board" do
    board.fill_cell(1,1).should == [1, 0, 0, 0, 0, 0, 0, 0, 0]
  end

  it "prints the display board" do
    board.fill_cell(2,-1)
    board.fill_cell(5,1)
    board.display_board.should == [0, -1, 0, 0, 1, 0, 0, 0, 0]
  end

end
