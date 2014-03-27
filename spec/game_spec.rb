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
    board.fill_cell(1, ai.token)
    board.fill_cell(5, ai.token)
    board.fill_cell(9, ai.token)

    game.winner.should == ai.token
  end
  it "the ai wins the game with a row" do
    board.fill_cell(1, ai.token)
    board.fill_cell(2, ai.token)
    board.fill_cell(3, ai.token)

    game.winner.should == ai.token
  end
  it "the ai wins the game with a column" do
    board.fill_cell(1, ai.token)
    board.fill_cell(4, ai.token)
    board.fill_cell(7, ai.token)

    game.winner.should == ai.token
  end


  it "the player wins the game with a diagonal" do
    board.fill_cell(1, player.token)
    board.fill_cell(5, player.token)
    board.fill_cell(9, player.token)

    game.winner.should == player.token
  end
  it "the player wins the game with a row" do
    board.fill_cell(1, player.token)
    board.fill_cell(2, player.token)
    board.fill_cell(3, player.token)

    game.winner.should == player.token
  end
  it "the player wins the game with a column" do
    board.fill_cell(1, player.token)
    board.fill_cell(4, player.token)
    board.fill_cell(7, player.token)

    game.winner.should == player.token
  end
end



