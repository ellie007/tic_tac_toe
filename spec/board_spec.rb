require 'board'

describe Board do

  let(:ai) { Ai.new({}) }
  let(:player) { Player.new }
  let(:board) { Board.new(3) }

  it "places a move for the player on the board" do
    board.fill_cell(4, player.token)

    expect(board.cells[3]).to eq(player.token)

  end
  it "places a move for the ai on the board" do
    board.fill_cell(1, ai.token)

    expect(board.cells[0]).to eq(ai.token)
  end

end
