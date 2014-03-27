class Game

  WELCOME = "Welcome to the Tic Tac Toe\n"
  USER_TURN  = "Your Turn: "
  AI_TURN = "Watson's Turn: "

  attr_accessor :board

  def initialize(board, ai, player)
    @board = board
    @player = player
    @ai = ai
  end

  def run
    puts WELCOME
    @board.display_board
    human_move
  end

  def human_move
    print USER_TURN
    move = @player.receive_move_input
    valid_input(move)
    valid_cell(move)
    @board.fill_cell(move, @player.token)
    winner && winner_exit
    @board.display_board
    ais_move
  end

  def ais_move
    rand_move = @ai.find_move
    puts AI_TURN + "#{rand_move}"
    @board.fill_cell(rand_move, @ai.token)
    winner && winner_exit
    @board.display_board
    human_move
  end

  def winner
    win_possibilities = [[0,1,2], [3,4,5], [6,7,8],
    [0,3,6], [1,4,7], [2,5,8],
    [0,4,8],[2,4,6]]

    win_possibilities.each do |set|
      @sum = 0
      set.each do |cell|
        if board.cells[cell] == @player.token
          @sum += 1
        elsif board.cells[cell] == @player.token
          @sum -= 1
        end
      end
      break if @sum == 3 || @sum == -3
    end

    if @sum == 3
      puts "Watson Wins!"
      return @ai.token
    elsif @sum == -3
      puts "You Win!"
      return @player.token && exit
    else
      return nil
    end
  end

  def winner_exit
    @board.display_board
    exit if winner == @ai.token || winner == @player.token
  end

  def valid_input(move)
    valid_move = [1,2,3,4,5,6,7,8,9]
    if !valid_move.include?(move)
      puts "Please enter a valid input.  Only values 1 to 9."
      human_move
    end
  end

  def valid_cell(move)
    if @board.cells[move - 1] == @player.token || @board.cells[move -1] == @ai.token
      puts "That spot is already taken.  Please choose an empty spot."
      @board.display_board
      human_move
    end
  end

end
