module Luhn
  def self.valid?(code)
    normalized = code.delete(' ') # ignore spaces
    return false unless normalized.delete('0-9').empty? # check for illegal characters
    return false unless normalized.length > 1           # check if too short

    #
    # In short, after multiplying each second digit (counting from right) by
    # two, the sum of all THOSE numbers' digits must be divisible by 10.
    #
    # Equivalently, after doubling every other digit, subtract 9 from any of
    # them that are greater than nine. Then sum the digits as above.
    #
    # Here's one way to do it that allows for nice, easy-to-follow comments:
    #
    normalized                                    #         Start with the normalized string : "055444285"
      .chars.reverse.map(&:to_i)                  #     Consider the digits in reverse order : [5,  8, 2, 4, 4, 4, 5,  5, 0]
      .map.with_index {|d, i| d * (1 + (i % 2))}  #                Double every second digit : [5, 16, 2, 8, 4, 8, 5, 10, 0]
      .map {|d| d > 9 ? d - 9 : d }               #         Subtract 9 from any that are > 9 : [5,  7, 2, 8, 4, 8, 5,  1, 0]
      .reduce(&:+)                                #                          Sum all of them : 40
      .modulo(10) == 0                            # Validate if that sum is a multiple of 10 : true
  end
end
