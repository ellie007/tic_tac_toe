require '../board/lib/board'

require 'player'

describe Player do

  let(:board) { Board.new }

  let(:player) { Player.new(board) }

  it "sends a player move to the board and record" do
    player.player_make_move(8)
  end

end
