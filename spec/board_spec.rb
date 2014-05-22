require 'board'

describe Board do

  let(:board) { Board.new(3) }

  it "initializes the cells" do
    expect(board.cells.length).to eq(9)
  end

  it "places a move for the player on the board" do
    board.fill_cell(4, "X")

    expect(board.cells[3]).to eq("X")
  end

end
