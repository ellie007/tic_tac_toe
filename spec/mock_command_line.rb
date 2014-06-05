class MockCommandLine

  attr_accessor :size, :dimension

  def initialize
    @printed_strings = []
  end

  def printed_strings
    @printed_strings
  end

  def display_board(cells)
    output(display_board_message)
  end

  def display_board_message
    "DISPLAY BOARD"
  end

  def input

  end

  def output(message)
    @printed_strings << message
  end

  def clear_screen

  end

end
