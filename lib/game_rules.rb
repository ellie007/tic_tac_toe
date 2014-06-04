class GameRules

  def initialize(board)
    @board = board
    @size = board.size
  end

  def row_winner?(board)
    row_column_win_checker(split_board(board))
  end

  def column_winner?(board)
    row_column_win_checker(split_board(board).transpose)
  end

  def principal_diagonal_winner?(board)
    diagonal_win_checker(create_principal_diagonal(board))
  end

  def counter_diagonal_winner?(board)
    diagonal_win_checker(create_counter_diagonal(board))
  end

  def winner?
    dice_dimensional_board.each_with_index do |board, index|
      return true if row_winner?(board) ||
        column_winner?(board) ||
        principal_diagonal_winner?(board) ||
        counter_diagonal_winner?(board)
    end
    return false
  end

  def is_tie?
    @board.cells.select { |cell| cell.nil? }.empty?
  end

  def game_over?
    winner? || is_tie?
  end

private

  def dice_dimensional_board
    @boards = []
    if @board.dimension == 2
      @boards << @board.cells
    else
      x_axis
      z_axis
      y_axis
    end
    @boards
  end

  def x_axis
    @board.cells.each_slice(@size**2) { |sub_board| @boards << sub_board }
  end

  def z_axis
    temp = []
    @size.times { |i| temp << @size * (@size * i) }
    board = []
    @size.times { |i| board << temp.map { |x| x + (i * @size) } }
    @size.times { |i| @boards << board.flatten.map { |x| @board.cells[x + i] } }
  end

  def y_axis
    temp = []
    @size.times { |i| temp << i }
    board = []
    @size.times { |i| board << temp.map { |x| x + (i * @size**2) } }
    boards = []
    @size.times { |i| @boards << board.flatten.map { |x| @board.cells[x + (@size * i)]} }
  end

  def split_board(board)
    split_board = []
    board.each_slice(@board.size) { |row| split_board << row }
    split_board
  end

  def row_column_win_checker(split_board)
    split_board.each do |row|
      return true if row.uniq.count == 1 && row.uniq[0] != nil
    end
    return false
  end

  def create_principal_diagonal(board)
    create_diagonal(board, 0, 1)
  end

  def create_counter_diagonal(board)
    create_diagonal(board, @size-1, -1)
  end

  def create_diagonal(board, i_value, incrementor)
    values = []
    board.each_with_index do |cell, index|
      if index % @size == 0
        values << board[index + i_value]
        i_value += incrementor
      end
    end
    values
  end

  def diagonal_win_checker(values)
    return true if values.uniq.count == 1 && values.uniq[0] != nil
    return false
  end

end
