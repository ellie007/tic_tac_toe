class GameRules

  def winner
    win_possibilities = [[0,1,2], [3,4,5], [6,7,8],
    [0,3,6], [1,4,7], [2,5,8],
    [0,4,8],[2,4,6]]

    win_possibilities.each do |set|
      @sum = 0
      set.each do |cell|
        if board.cells[cell] == " O "
          @sum += 1
        elsif board.cells[cell] == " X "
          @sum -= 1
        end
      end
      break if @sum == 3 || @sum == -3
    end

    if @sum == 3
      return @ai.ai_sign
    elsif @sum == -3
      return @player.player_sign
    else
      return nil
    end
  end

end

