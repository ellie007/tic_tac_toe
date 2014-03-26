require 'game'
require 'board'

describe Game do

  let(:board) { Board.new }
  let(:ai)    { Ai.new(board.cells) }
  let(:player) { Player.new }
  let(:game)  { Game.new(board, ai, player) }

  it "has no winner at the beginning of the game" do
    game.winner.should == nil
  end

  it "the ai wins the game with a diagonal" do
    board.fill_cell(1, ai.ai_sign)
    board.fill_cell(5, ai.ai_sign)
    board.fill_cell(9, ai.ai_sign)

    game.winner.should == ai.ai_sign
  end
  it "the ai wins the game with a row" do
    board.fill_cell(1, ai.ai_sign)
    board.fill_cell(2, ai.ai_sign)
    board.fill_cell(3, ai.ai_sign)

    game.winner.should == ai.ai_sign
  end
  it "the ai wins the game with a column" do
    board.fill_cell(1, ai.ai_sign)
    board.fill_cell(4, ai.ai_sign)
    board.fill_cell(7, ai.ai_sign)

    game.winner.should == ai.ai_sign
  end


  it "the player wins the game with a diagonal" do
    board.fill_cell(1, player.player_sign)
    board.fill_cell(5, player.player_sign)
    board.fill_cell(9, player.player_sign)

    game.winner.should == player.player_sign
  end
  it "the player wins the game with a row" do
    board.fill_cell(1, player.player_sign)
    board.fill_cell(2, player.player_sign)
    board.fill_cell(3, player.player_sign)

    game.winner.should == player.player_sign
  end
  it "the player wins the game with a column" do
    board.fill_cell(1, player.player_sign)
    board.fill_cell(4, player.player_sign)
    board.fill_cell(7, player.player_sign)

    game.winner.should == player.player_sign
  end
end


