require 'game_rules'

describe GameRules do

  let(:board) { Board.new(3) }
  let(:player_1) { Player.new }
  let(:player_2) { Player.new }
  let(:game_rules) { GameRules.new(board) }

  it "is a tie game" do
    player_1.token = "X"
    player_2.token = "O"
    winner = nil
    tie_game

    game_rules.is_tie?.should == true
  end

 #THESE TESTS NEED TO BE FIXED!!!!!!
  context 'game over' do
    it "game over is true with tie game" do
      player_1.token = "X"
      player_2.token = "O"
      winner = nil
      tie_game

      game_rules.game_over(winner).should == true
    end

    it "game over is true with a winner" do
      player_1.token = "X"
      winner = player_1

      game_rules.game_over(winner) == true
    end

    it "game is not over with no winner" do
      winner = nil

      game_rules.game_over(winner) == false
    end

    it "game is not over mid game" do
      player_1.token = "X"
      player_2.token = "O"

      winner = nil
      game_rules.game_over(winner) == false
    end
  end

end

private

def tie_game
  board.fill_cell(1, player_1.token)
  board.fill_cell(2, player_1.token)
  board.fill_cell(3, player_2.token)
  board.fill_cell(4, player_2.token)
  board.fill_cell(5, player_2.token)
  board.fill_cell(6, player_1.token)
  board.fill_cell(7, player_1.token)
  board.fill_cell(8, player_2.token)
  board.fill_cell(9, player_1.token)
end
