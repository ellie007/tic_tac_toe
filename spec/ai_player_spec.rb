require 'ai_player'
require 'board'
require 'hard_ai'
require 'human_player'

describe AiPlayer do

  let(:board) { Board.new }
  let(:hard_ai) { HardAi.new }
  let(:human_player) { HumanPlayer.new({}) }
  let(:ai_player) { AiPlayer.new(hard_ai) }

  it 'uses minimax to find the best move' do
    human_player.token = "X"
    ai_player.token = "O"

    expect(ai_player.make_move(ai_player.token, human_player.token, 2, board)).to eq(0)
  end

end
