require 'ai_player'
require 'board'
require 'easy_ai'
require 'human_player'

describe EasyAi do

  let(:board) { Board.new }
  let(:easy_ai) { EasyAi.new(board) }

  let(:human_options) { {:name => 'fake_human_name', :token => 'X'} }
  let(:human_player) { HumanPlayer.new(human_options, {}) }

  let(:ai_options) { {:name => 'easy_ai', :token => 'O'} }
  let(:ai_player) { AiPlayer.new(ai_options, easy_ai) }

  it "finds a move randomly for the easy ai" do
    expect((0..board.cells.length - 1).include?(ai_player.make_move(ai_player.token, human_player.token, 3))).to eq(true)
  end

end

