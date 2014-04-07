# rename to MockCommandLine
class MockOutput

  def initialize(cells, ai, player)
    @cells = cells
    @ai = ai
    @player = player
    @printed_strings = []
  end

  def printed_strings
    @printed_strings
  end

  def output_message(message)
    @printed_strings << message
  end


  def display_board
    output_message display_board_message
  end

  def display_board_message
    'DISPLAY BOARD'
  end
end
