require 'menu'
require 'game'
require 'player'
require 'board'

describe Board do
  let(:menu) { Menu.new }
  let(:player_1) { Player.new }
  let(:player_2) { Player.new}
  let(:board) { Board.new(3) }
  let(:game) { Game.new(board,{},{},menu,player_1,player_2) }


  it "places a move for the player on the board" do
    player_1.token  = "X"
    board.fill_cell(4, player_1.token)
    expect(board.cells[3]).to eq(player_1.token)
  end

end
