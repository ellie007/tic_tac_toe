require 'ai'
require 'ai_player'

describe AiPlayer do

  let(:board) { Board.new }
  let(:ai) { Ai.new(board) }

  let(:human_options) { {:name => 'min', :token => 'X'} }
  let(:human_player) { HumanPlayer.new(human_options, {}) }

  let(:ai_options) { {:name => 'max', :token => 'O'} }
  let(:ai_player) { AiPlayer.new(ai_options, ai) }


  it 'uses minimax to find the best move' do
    expect(ai_player.make_move(ai_player.token, human_player.token, 2)).to eq(0)
  end

end
