module OcrNumbers
  DIGITS = {
    [" _ ", "| |", "|_|", "   "] => '0',
    ["   ", "  |", "  |", "   "] => '1',
    [" _ ", " _|", "|_ ", "   "] => '2',
    [" _ ", " _|", " _|", "   "] => '3',
    ["   ", "|_|", "  |", "   "] => '4',
    [" _ ", "|_ ", " _|", "   "] => '5',
    [" _ ", "|_ ", "|_|", "   "] => '6',
    [" _ ", "  |", "  |", "   "] => '7',
    [" _ ", "|_|", "|_|", "   "] => '8',
    [" _ ", "|_|", " _|", "   "] => '9'
  }
  def self.convert(input_string)
    input_lines = input_string.split("\n")
    raise ArgumentError unless input_lines.length % 4 == 0
    raise ArgumentError unless input_lines.all? { |l| l.length % 3 == 0 }
    numbers = input_lines.each_slice(4)
    digit_arrays = numbers.map do |number|
      digit_slices = number.map { |l| l.scan(/.../) }
      digit_slices.shift.zip(*digit_slices)
    end
    digit_arrays.map { |da| da.map { |d| DIGITS[d].nil? ? '?' : DIGITS[d] }.join('') }.join(',')
  end
end
