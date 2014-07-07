require 'hard_ai'
require 'board'
require 'ai_player'
require 'human_player'

describe HardAi do

  let(:board) { Board.new }
  let(:hard_ai) { HardAi.new(board) }

  let(:human_options) { {:name => 'minnie_mouse', :token => 'X'} }
  let(:human_player) { HumanPlayer.new(human_options, {}) }

  let(:ai_options) { {:name => 'maximus_prime', :token => 'O'} }
  let(:ai_player) { AiPlayer.new(ai_options, hard_ai) }

  context "use of minimax (difficult ai) to find the best move:" do
    it "strikes with a winning move" do
      board.cells = [ "O", "X", "O",
                      nil, "X", nil,
                      "X", nil, "O" ]

      expect(ai_player.make_move(ai_player.token, human_player.token, 2)).to eq(5)
    end

    it "minimax blocks an opponent move" do
      board.cells = [ "X", nil, nil,
                      nil, "O", nil,
                      "X", nil, nil ]

      expect(ai_player.make_move(ai_player.token, human_player.token, 2)).to eq(3)
    end

    it "minimax blocks an opponent fork" do
      board.cells = [ "X", nil, nil,
                      nil, "O", nil,
                      nil, nil, "X" ]

      expect(ai_player.make_move(ai_player.token, human_player.token, 2)).to eq(1)
    end
  end

end
