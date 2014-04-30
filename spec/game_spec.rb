require 'game'
require 'board'
require 'ai'
require 'player'
require 'mock_output'
require 'menu'

describe Game do

  let(:menu) { Menu.new }
  let(:board) { Board.new(3, 2) }
  let(:ai) { Ai.new(board.cells) }
  let(:player_1) { Player.new }
  let(:player_2) { Player.new }
  let(:mock_io) { MockCommandLine.new(board) }
  let(:game) { Game.new(board, ai, mock_io, menu, player_1, player_2) }

  context 'run' do
    it 'prints the welcome message and displays the board' do #, t:true do
      game.stub(:set_players)
      game.stub(:game_loop)
      game.stub(:winner_display)
      game.stub(:play_again?)
      game.run

      expect(mock_io.printed_strings[0]).to eq(mock_io.display_board_message)
    end
  end

  context 'play again: ' do
    it "set to true" do
      allow(mock_io).to receive(:play_again).and_return('a', 1, 'y')
      game.play_again?
      game.play_again.should == true
    end

    it "set to false" do
      allow(mock_io).to receive(:play_again).and_return('n')
      game.play_again?
      game.play_again.should == false
    end
  end

  context 'settings' do
    it "should set current player : nil" do
      menu.turn_response = nil
      game.set_current_player
      game.current_player.should == player_1
    end

    it "should set current player : 1" do
      menu.turn_response = 1
      game.set_current_player.should == player_1
    end

    it "should set current player : 2" do
      menu.turn_response = 2
      game.set_current_player.should == player_2
    end

    it "should set player types : 1" do
      menu.game_type_response = 1
      game.set_players
      player_1.type.should == 'human'
      player_2.type.should == 'human'
    end

    it "should set player types : 2" do
      menu.game_type_response = 2
      game.set_players
      player_1.type.should == 'human'
      player_2.type.should == 'ai'
    end

    it "should set player types : 3" do
      menu.game_type_response = 3
      game.set_players
      player_1.type.should == 'ai'
      player_2.type.should == 'ai'
    end

    it "should set tokens and names" do
      menu.player_one_name = 'Eleanor'
      menu.player_one_token = 'X'
      menu.player_two_name = 'Vivian'
      menu.player_two_token = 'O'

      game.token_and_name

      player_1.name.should == 'Eleanor'
      player_1.token.should == 'X'
      player_2.name.should == 'Vivian'
      player_2.token.should == 'O'
    end
  end

  context 'should make the correct type of move based on player type: ' do
    it "ai type" do
      player_1.name = 'Eleanor'
      player_1.type = 'ai'
      player_1.token = "O"
      @current_player = game.set_current_player
      allow(ai).to receive(:find_move).and_return(4)
      game.make_move

      expect(board.cells[3]).to eq(@current_player.token)
    end

    it "human type" do
      player_1.name = 'Eleanor'
      player_1.type = 'human'
      player_1.token = "X"
      @current_player = game.set_current_player
      allow(mock_io).to receive(:player_input).and_return(3)
      game.make_move

      expect(board.cells[2]).to eq(@current_player.token)
    end
  end

  it "should toggle the current player" do
    @current_player = game.set_current_player
    @current_player.should == player_1
    game.toggle_current_player.should == player_2
    game.toggle_current_player.should == player_1
  end

  context "human turn" do
    it "keeps prompting human for input until valid input" do
      player_1.name = "Eleanor"
      player_1.token = "X"
      @current_player = game.set_current_player
      allow(mock_io).to receive(:player_input).and_return(123, 'a', 5)
      game.human_turn

      expect(mock_io.printed_strings[0]).to match /That is invalid input./
      expect(mock_io.printed_strings[1]).to eq(mock_io.display_board_message)
      expect(mock_io.printed_strings[2]).to match /That is invalid input./
      expect(mock_io.printed_strings[3]).to eq(mock_io.display_board_message)
      expect(mock_io.printed_strings[4]).to eq(mock_io.display_board_message)

      expect(board.cells[4]).to eq(@current_player.token)
    end

    it "keeps prompting human for input until valid cell" do
      player_1.name = "Eleanor"
      player_1.token = "X"
      @current_player = game.set_current_player
      board.fill_cell(1, @current_player.token)
      allow(mock_io).to receive(:player_input).and_return(1,2)
      game.human_turn

      expect(board.cells[1]).to eq(@current_player.token)
      expect(mock_io.printed_strings[0]).to match /That spot is already taken./
      expect(mock_io.printed_strings[1]).to eq(mock_io.display_board_message)
      expect(mock_io.printed_strings[2]).to eq(mock_io.display_board_message)
    end
  end

  context "ai turn" do
    it "ai gets random move, sends correct message, and fills the board" do
      player_1.name = "Eleanor"
      player_1.token = "X"
      @current_player = game.set_current_player
      #ai.stub find_move: 5
      allow(ai).to receive(:find_move).and_return(5)
      game.ai_turn

      expect(mock_io.printed_strings[0]).to match /Eleanor's turn: 5/i
      expect(mock_io.printed_strings[1]).to eq(mock_io.display_board_message)
    end
  end

  context "calculates sum" do
    it "adds one for a current player token" do
      player_1.token = "X"
      @current_player = game.set_current_player

      cell = @current_player.token
      game.sum = 0
      game.calculate_sum(cell)
      game.sum.should == 1
    end
  end

  context "correctly sets the winner based on sum" do
    it "the winner is set with the player token" do
      player_1.token = "X"
      @current_player = game.set_current_player
      game.sum = 3

      game.set_winner.should == @current_player.token
    end
  end

  context "winner determination:" do
    it "has no winner at the beginning of the game" do
      game.winner.should == nil
    end

    it "player wins the game with a row" do
      player_1.token = "X"
      @current_player = game.set_current_player
      board.fill_cell(1, @current_player.token)
      board.fill_cell(2, @current_player.token)
      board.fill_cell(3, @current_player.token)
      game.row_winner(board.cells).should == @current_player.token

      menu.dimension_response = 2
      game.winner = nil
      game.is_winner.should == @current_player.token
    end

    it "player wins the game with a column" do
      player_1.token = "X"
      @current_player = game.set_current_player
      board.fill_cell(1, @current_player.token)
      board.fill_cell(4, @current_player.token)
      board.fill_cell(7, @current_player.token)
      game.column_winner(board.cells).should == @current_player.token

      menu.dimension_response = 2
      game.winner = nil
      game.is_winner.should == @current_player.token
    end

    it "player wins the game with a principal diagonal" do
      player_1.token = "X"
      @current_player = game.set_current_player
      board.fill_cell(1, @current_player.token)
      board.fill_cell(5, @current_player.token)
      board.fill_cell(9, @current_player.token)
      game.principal_diagonal_winner(board.cells).should == @current_player.token

      menu.dimension_response = 2
      game.winner = nil
      game.is_winner.should == @current_player.token
    end

    it "player wins the game with a counter diagonal" do
      player_1.token = "X"
      @current_player = game.set_current_player
      board.fill_cell(3, @current_player.token)
      board.fill_cell(5, @current_player.token)
      board.fill_cell(7, @current_player.token)
      game.counter_diagonal_winner(board.cells).should == @current_player.token

      menu.dimension_response = 2
      game.winner = nil
      game.is_winner.should == @current_player.token
    end

    it "is a tie game" do
      player_1.token = "X"
      player_2.token = "O"

      board.fill_cell(1, player_1.token)
      board.fill_cell(2, player_1.token)
      board.fill_cell(3, player_2.token)
      board.fill_cell(4, player_2.token)
      board.fill_cell(5, player_2.token)
      board.fill_cell(6, player_1.token)
      board.fill_cell(7, player_1.token)
      board.fill_cell(8, player_2.token)
      board.fill_cell(9, player_1.token)

      game.is_tie?.should == true
    end
  end

  context 'winner_display' do
    it "displays the winner of the game when there is a winner" do
      player_1.name = "Eleanor"
      game.set_current_player
      game.winner_display

      expect(mock_io.printed_strings[0]).to eq(mock_io.display_board_message)
      expect(mock_io.printed_strings[1]).to match /eleanor won!/i
    end

    it 'displays it was a tie game' do
        player_1.token = "X"
        player_2.token = "O"

        board.fill_cell(1, player_1.token)
        board.fill_cell(2, player_1.token)
        board.fill_cell(3, player_2.token)
        board.fill_cell(4, player_2.token)
        board.fill_cell(5, player_2.token)
        board.fill_cell(6, player_1.token)
        board.fill_cell(7, player_1.token)
        board.fill_cell(8, player_2.token)
        board.fill_cell(9, player_1.token)

        game.winner_display

        expect(mock_io.printed_strings[1]).to match /tie game/
    end
  end

  context "player input validation" do
    it "should return a false value for an invalid input type" do
      game.valid_input?(123).should == false
    end

    it "should return a true value for a valid input type" do
      game.valid_input?(1).should == true
    end

    it "should not allow the player to place in a taken cell" do
      player_1.token = "X"
      @current_player = game.set_current_player

      board.fill_cell(5, @current_player.token)
      game.valid_cell?(5).should == false
    end

    it "should allow the player to place in an empty cell" do
      game.valid_cell?(5).should == true
    end
  end

  context "determines when game is over: " do
    it "when tie game" do
      player_1.token = "X"
      player_2.token = "O"

      board.fill_cell(1, player_1.token)
      board.fill_cell(2, player_1.token)
      board.fill_cell(3, player_2.token)
      board.fill_cell(4, player_2.token)
      board.fill_cell(5, player_2.token)
      board.fill_cell(6, player_1.token)
      board.fill_cell(7, player_1.token)
      board.fill_cell(8, player_1.token)
      board.fill_cell(9, player_2.token)

      game.game_over.should == true
    end

    it "when there is a winner" do
      game.winner = player_1.token = "X"
      game.game_over == true
    end

    it "is not over with no winner" do
      game.winner = nil
      game.game_over == false
    end

    it "not over mid game" do
      player_1.token = "X"
      player_2.token = "O"

      board.fill_cell(1, player_1.token)
      board.fill_cell(5, player_2.token)
      game.game_over.should == false
    end
  end

end

describe Game do

  let(:menu) { Menu.new }
  let(:board) { Board.new(3, 3) }
  let(:ai) { Ai.new(board.cells) }
  let(:player_1) { Player.new }
  let(:player_2) { Player.new }
  let(:mock_io) { MockCommandLine.new(board) }
  let(:game) { Game.new(board, ai, mock_io, menu, player_1, player_2) }

  it "vertical straight - should find a row winner" do
    menu.dimension_response = 3
    player_1.token = "X"
    @current_player = game.set_current_player
    board.fill_cell(13, @current_player.token)
    board.fill_cell(14, @current_player.token)
    board.fill_cell(15, @current_player.token)

    game.is_winner.should == @current_player.token
  end

  xit "column straight - should find a column winner" do
    menu.dimension_response = 3
    player_1.token = "X"
    @current_player = game.set_current_player
    board.fill_cell(11, @current_player.token)
    board.fill_cell(14, @current_player.token)
    board.fill_cell(17, @current_player.token)

    game.is_winner.should == @current_player.token
  end

  it "vertical side - should find a row winner" do
    menu.dimension_response = 3
    player_1.token = "X"
    @current_player = game.set_current_player
    board.fill_cell(7, @current_player.token)
    board.fill_cell(16, @current_player.token)
    board.fill_cell(25, @current_player.token)

    game.is_winner.should == @current_player.token
  end

end


