class GameState

  def initialize(cells)
    @cells = cells
  end

  def find_nil_places
    possible_places = []
    @cells.each_with_index do |cell, index|
      if cell.nil?
        possible_places << index
      end
    end
    possible_places
  end

  # def minimax
  #   find_nil_places.each do |space|
  #     game over?
  #       if computer win return 1
  #         if tie return 0
  #           if computer lose return -1
  #             scoreboard <<


  #           end
  #           find_nil_places
  #   end
  # end



end
