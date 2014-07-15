require 'ai_player'
require 'board'
require 'hard_ai'
require 'human_player'

describe HardAi do

  let(:board) { Board.new }
  let(:hard_ai) { HardAi.new }

  let(:human_player) { HumanPlayer.new({}) }
  let(:ai_player) { AiPlayer.new(hard_ai) }

  before(:each) do
    human_player.name = 'minnie_mouse'
    human_player.token = 'X'

    ai_player.name = 'maximus_prime'
    ai_player.token = 'O'
  end

  context "use of minimax (difficult ai) to find the best move:" do
    it "strikes with a winning move" do
      board.cells = [ "O", nil, "O",
                      nil, "X", "X",
                      "X", nil, "O" ]

      expect(ai_player.make_move(ai_player.token, human_player.token, 2, board)).to eq(1)
    end

    it "gives precedence to winning versus blocking" do
      board.cells = [ "O", "X", "O",
                      nil, "X", nil,
                      "X", nil, "O" ]
      expect(ai_player.make_move(ai_player.token, human_player.token, 2, board)).to eq(5)
    end

    it "minimax blocks an opponent move" do
      board.cells = [ "X", nil, nil,
                      nil, "O", nil,
                      "X", nil, nil ]

      expect(ai_player.make_move(ai_player.token, human_player.token, 2, board)).to eq(3)
    end

    it "minimax blocks an opponent fork" do
      board.cells = [ "X", nil, nil,
                      nil, "O", nil,
                      nil, nil, "X" ]

      expect(ai_player.make_move(ai_player.token, human_player.token, 2, board)).to eq(1)
    end
  end

end
