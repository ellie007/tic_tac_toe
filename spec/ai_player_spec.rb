require 'hard_ai'
require 'ai_player'
require 'board'
require 'human_player'

describe AiPlayer do

  let(:board) { Board.new }
  let(:hard_ai) { HardAi.new(board) }

  let(:human_options) { {:name => 'minnie_mouse', :token => 'X'} }
  let(:human_player) { HumanPlayer.new(human_options, {}) }

  let(:ai_options) { {:name => 'maximus_prime', :token => 'O'} }
  let(:ai_player) { AiPlayer.new(ai_options, hard_ai) }


  it 'uses minimax to find the best move' do
    expect(ai_player.make_move(ai_player.token, human_player.token, 2)).to eq(0)
  end

end
