require 'ai_player'

describe AiPlayer do

  let(:ai) { Ai.new({}) }
  let(:ai_player) { AiPlayer.new('fake_name', 'X', ai) }

  it 'randomly finds an available move' do
    allow(ai_player).to receive(:make_move).and_return(5)

    expect(ai_player.make_move).to eq(5)
  end

end
