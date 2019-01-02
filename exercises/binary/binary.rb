module Binary
  def self.to_decimal(bin_string)
    raise ArgumentError if bin_string.match(/[^01]/)

    bin_string
      .reverse.each_char                                # get enumerator, least significant digits first
      .map.with_index { |c, i| c == '1' ? 2 ** i : 0 }  # replace each digit with its value in binary
      .reduce(:+)                                       # sum them all up
  end
end
