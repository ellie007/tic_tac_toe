require '../board/lib/board'

require 'ai'

describe Ai do

  let(:board) { Board.new }

  let(:ai) { Ai.new(board) }

  it "should send the board a move and record it" do
    ai.ai_make_move(2)
  end

end
