require 'ai'
require 'board'
require 'ai_player'
require 'human_player'

describe Ai do

  let(:board) { Board.new }
  let(:ai) { Ai.new(board) }

  let(:human_options) { {:name => 'min', :token => 'X', :type => 1} }
  let(:player_1) { HumanPlayer.new(human_options, {}) }

  let(:ai_options) { {:name => 'max', :token => 'O', :type => 2} }
  let(:player_2) { AiPlayer.new(ai_options, ai) }


  it "strikes with a winning move" do
    board.cells = [ "O", "X", "O",
                    nil, "X", nil,
                    "X", nil, "O" ]

    expect(ai.find_move(player_2, [player_1, player_2], board)).to eq(5)
  end

  it "blocks an opponent move" do
    board.cells = [ "X", nil, nil,
                    nil, "O", nil,
                    "X", nil, nil ]

    expect(ai.find_move(player_2, [player_1, player_2], board)).to eq(3)
  end

  it "blocks an opponent fork" do
    board.cells = [ "X", nil, nil,
                    nil, "O", nil,
                    nil, nil, "X" ]

    expect(ai.find_move(player_2, [player_1, player_2], board)).to eq(1)
  end

end
