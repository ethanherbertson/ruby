module BaseConverter
  def self.convert(input_base, digits, output_base)
    raise ArgumentError if digits.any? {|d| d >= input_base || d < 0}
    raise ArgumentError if input_base < 2 || output_base < 2
    raise ArgumentError unless input_base.integer? && output_base.integer?

    # Get the true number encoded by digits:
    value = digits
      .reverse
      .map.with_index {|d, i| d * (input_base ** i)}
      .reduce(:+)

    # Handle degenerate cases:
    return [0] if value == 0
    return [] if value.nil?

    # For each power of output_base <= value, divide the value by that power.
    # Use the quotient as the digit at that position in the output array, and
    # use the remainder as the remaining value.
    (0..Math.log(value, output_base).floor)
      .to_a
      .reverse
      .map do |n|
        quotient, value = value.divmod(output_base ** n)
        quotient
      end
  end
end
