require 'board'
require 'ai'

describe Ai do

  let(:board) { Board.new(3) }
  let(:ai) { Ai.new(board.cells) }

  it "finds a random move" do
    expect((1..board.size**2).include?(ai.find_move)).to eq(true)
  end

end
