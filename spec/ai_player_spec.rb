require 'ai'
require 'ai_player'

describe AiPlayer do

  let(:ai) { Ai.new({}) }
  let(:options) { {:name => 'fake_name', :token => 'X'} }
  let(:ai_player) { AiPlayer.new(options, ai) }

  it 'randomly finds an available move' do
    allow(ai).to receive(:find_move).and_return(5)

    expect(ai_player.make_move).to eq(5)
  end

end
