# TODO Should support uppercase as well, probably...
# Should probably use String.hex from core, but rules are rules
class Hexadecimal
  CODING = {
    '0' =>  0,
    '1' =>  1,
    '2' =>  2,
    '3' =>  3,
    '4' =>  4,
    '5' =>  5,
    '6' =>  6,
    '7' =>  7,
    '8' =>  8,
    '9' =>  9,
    'a' => 10,
    'b' => 11,
    'c' => 12,
    'd' => 13,
    'e' => 14,
    'f' => 15,
  }

  def initialize(str)
    @str = str
  end

  def to_decimal
    return 0 if @str.count('^0-9a-f') > 0

    @str.chars.reverse.each.with_index.reduce(0) do |sum, (char, index)|
      sum + CODING[char] * (16 ** index)
    end
  end
end
