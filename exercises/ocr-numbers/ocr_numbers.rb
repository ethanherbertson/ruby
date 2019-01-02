module OcrNumbers
  def self.convert(input_string)
    #
    # Split on, and remove, all newlines:
    #
    input_lines = input_string.split("\n")

    #
    # Raise an error unless we have a multiple of 4 lines:
    #
    raise ArgumentError unless input_lines.length % 4 == 0

    #
    # Raise an error unless all lines are a multiple of 3 characters long:
    #
    raise ArgumentError unless input_lines.all? { |l| l.length % 3 == 0 }

    #
    # Convert
    #
    # ┏               ┓
    # ┃  " _    ",    ┃      ┏                              ┓
    # ┃  "|_||_|",    ┃      ┃ ┌          ┐ ┌             ┐ ┃
    # ┃  " _|  |",    ┃      ┃ │ " _    ",│ │ "    _  _ ",│ ┃
    # ┃  "      ",    ┃  to  ┃ │ "|_||_|",│ │ "  || | _|",│ ┃
    # ┃  "    _  _ ", ┃ ===> ┃ │ " _|  |",│ │ "  ||_| _|",│ ┃
    # ┃  "  || | _|", ┃      ┃ │ "      " │ │ "         " │ ┃
    # ┃  "  ||_| _|", ┃      ┃ └          ┘,└             ┘ ┃
    # ┃  "         "  ┃      ┗                              ┛
    # ┗               ┛
    #
    numbers = input_lines.each_slice(4)

    #
    # Convert
    #                                       ┏                                                          ┓
    # ┏                              ┓      ┃ ┌                     ┐ ┌                              ┐ ┃
    # ┃ ┌          ┐ ┌             ┐ ┃      ┃ │ ┌       ┐ ┌       ┐ │ │ ┌      ┐ ┌       ┐ ┌       ┐ │ ┃
    # ┃ │ " _    ",│ │ "    _  _ ",│ ┃      ┃ │ │ " _ ",│ │ "   ",│ │ │ │"   ",│ │ " _ ",│ │ " _ ",│ │ ┃
    # ┃ │ "|_||_|",│ │ "  || | _|",│ ┃  to  ┃ │ │ "|_|",│ │ "|_|",│ │ │ │"  |",│ │ "| |",│ │ " _|",│ │ ┃
    # ┃ │ " _|  |",│ │ "  ||_| _|",│ ┃ ===> ┃ │ │ " _|",│ │ "  |",│ │ │ │"  |",│ │ "|_|",│ │ " _|",│ │ ┃
    # ┃ │ "      " │ │ "         " │ ┃      ┃ │ │ "   " │ │ "   " │ │ │ │"   " │ │ "   " │ │ "   " │ │ ┃
    # ┃ └          ┘,└             ┘ ┃      ┃ │ └       ┘,└       ┘ │ │ └      ┘,└       ┘,└       ┘ │ ┃
    # ┗                              ┛      ┃ └                     ┘,└                              ┘ ┃
    #                                       ┗                                                          ┛
    #
    digit_arrays = numbers.map do |number|
      digit_slices = number.map { |l| l.scan(/.../) } # make each line become an array of 3-character strings
      digit_slices.shift.zip(*digit_slices)           # transpose from line-wise to digit-wise arrays
    end

    #
    # Return the numbers, separated by commas, and with unrecognized digits replaced by '?':
    #
    digit_arrays.map { |da| da.map { |d| DIGITS[d].nil? ? '?' : DIGITS[d] }.join('') }.join(',')
  end

  #
  # I don't know of a prettier way of doing this:
  #
  DIGITS = {
    [" _ ",
     "| |",
     "|_|",
     "   "] => '0',
    ["   ",
     "  |",
     "  |",
     "   "] => '1',
    [" _ ",
     " _|",
     "|_ ",
     "   "] => '2',
    [" _ ",
     " _|",
     " _|",
     "   "] => '3',
    ["   ",
     "|_|",
     "  |",
     "   "] => '4',
    [" _ ",
     "|_ ",
     " _|",
     "   "] => '5',
    [" _ ",
     "|_ ",
     "|_|",
     "   "] => '6',
    [" _ ",
     "  |",
     "  |",
     "   "] => '7',
    [" _ ",
     "|_|",
     "|_|",
     "   "] => '8',
    [" _ ",
     "|_|",
     " _|",
     "   "] => '9'
  }
end
