require 'board'

describe Board do

  let(:ai) { Ai.new({}) }
  let(:player) { Player.new }
  let(:board) { Board.new }

  it "places a move for the player on the board" do
    board.fill_cell(4, player.token).should == ["   ","   ","   "," X ","   ","   ","   ","   ","   "]
  end
  it "places a move for the ai on the board" do
    board.fill_cell(1, ai.token).should == [" O ","   ","   ","   ","   ","   ","   ","   ","   "]
  end

end
