require 'ai'
require 'board'
require 'ai'

describe Ai do

  let(:board) { Board.new }
  let(:ai) { Ai.new(board) }

  # it "finds a random move" do
  #   expect((1..board.size**2).include?(ai.find_move)).to eq(true)
  # end

  it "strikes when there is an advantage/path towards winning" do
    board.cells = [ "X", nil, nil,
                    "O", nil, nil,
                    nil, nil, nil ]

    puts ai.minimax(board)
    ai.minimax(board)
  end

   xit "blocks an opponent move" do
    board.cells = [ nil, nil, nil,
                    nil, nil, nil,
                    nil, nil, nil ]

    puts ai.minimax(board)
    ai.minimax(board)
  end

end
