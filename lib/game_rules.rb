class GameRules

  def initialize(board)
    @board = board
    @size = board.size
  end

  def row_winner?
    row_column_win_checker(split_board)
  end

  def column_winner?
    row_column_win_checker(split_board.transpose)
  end

  def principal_diagonal_winner?
    diagonal_win_checker(create_diagonal(0, 1))
  end

  def counter_diagonal_winner?
    diagonal_win_checker(create_diagonal(@size-1, -1))
  end

  def winner?
    row_winner? || column_winner? || principal_diagonal_winner? || counter_diagonal_winner?
  end

  def is_tie?
    @board.cells.select { |cell| cell == nil }.empty?
  end

  def game_over
    winner? == true || is_tie?
  end

private

  def split_board
    split_board = []
    @board.cells.each_slice(@size) { |row| split_board << row }
    split_board
  end

  def row_column_win_checker(split_board)
    split_board.each do |row|
      return true if row.uniq.count == 1 && row.uniq[0] != nil
    end
    return false
  end

  def create_diagonal(i_value, incrementor)
    values = []
    i = i_value
    @board.cells.each_with_index do |cell, index|
      if index % @size == 0
        values << @board.cells[index + i]
        i += incrementor
      end
    end
    values
  end

  def diagonal_win_checker(values)
    return true if values.uniq.count == 1 &&  values.uniq[0] != nil
    return false
  end

end
