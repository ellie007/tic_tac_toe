require 'board'

describe Board do

  let(:board) { Board.new }

  it "initializes the cells" do
    expect(board.cells.length).to eq(9)
  end

  it "places a move for the player on the board" do
    board.fill_cell(4, "X")

    expect(board.cells[4]).to eq("X")
  end

end
