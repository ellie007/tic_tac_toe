require 'ai'
require 'board'
require 'ai_player'
require 'human_player'

describe Ai do

  let(:board) { Board.new }
  let(:ai) { Ai.new(board) }

  let(:human_options) { {:name => 'min', :token => 'X'} }
  let(:player_1) { HumanPlayer.new(human_options, {}) }

  let(:ai_options) { {:name => 'max', :token => 'O'} }
  let(:player_2) { AiPlayer.new(ai_options, ai) }

  context "use of minimax (difficult ai) to find the best move:" do
    it "strikes with a winning move" do
      board.cells = [ "O", "X", "O",
                      nil, "X", nil,
                      "X", nil, "O" ]

      expect(ai.find_move(player_2.token, player_1.token, 2, board)).to eq(5)
    end

    it "blocks an opponent move" do
      board.cells = [ "X", nil, nil,
                      nil, "O", nil,
                      "X", nil, nil ]

      expect(ai.find_move(player_2.token, player_1.token, 2, board)).to eq(3)
    end

    it "blocks an opponent fork" do
      board.cells = [ "X", nil, nil,
                      nil, "O", nil,
                      nil, nil, "X" ]

      expect(ai.find_move(player_2.token, player_1.token, 2, board)).to eq(1)
    end
  end

  context "use of simple(/random) ai to find a move" do
    it "finds a move randomly for the ai" do
      expect((0..board.cells.length - 1).include?(ai.find_move(player_2.token, player_1.token, 3, board))).to eq(true)
    end
  end

end
