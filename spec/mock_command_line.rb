class MockCommandLine

  attr_accessor :size

  def initialize
    @printed_strings = []
  end

  def printed_strings
    @printed_strings
  end

  def output_message(message)
    @printed_strings << message
  end

  def display_board(cells)
    output_message display_board_message
  end

  def display_board_message
    "DISPLAY BOARD"
  end

  def prompt_for_input(message)
    @printed_strings << message
  end

  def clear_screen

  end

end
