require 'ai_player'
require 'board'
require 'easy_ai'
require 'human_player'

describe EasyAi do

  let(:board) { Board.new }
  let(:easy_ai) { EasyAi.new }
  let(:human_player) { HumanPlayer.new({}) }
  let(:ai_player) { AiPlayer.new(easy_ai) }

  it "finds a move randomly for the easy ai" do
    human_player.token = "X"
    ai_player.token = "O"

    expect((0..board.cells.length - 1).include?(ai_player.make_move(ai_player.token, human_player.token, 2, board))).to eq(true)
  end

end

