require './lib/board'
require './lib/player'


describe Player do

  let(:board) { Board.new }

  let(:player) { Player.new(board) }

  it "sends a player move to the board and record" do
    player.player_make_move(8).should == [0,0,0,0,0,0,0,-1,0]
  end

end
