module Diamond
  def self.make_diamond(last_character)
    letters = ('A'..last_character).to_a
    num_spaces = letters.length - 1

    #
    # First we build the "top half" of the diamond:
    #
    top_half = letters
      .map.with_index {|ltr, idx| (' ' * num_spaces).insert(num_spaces - idx, ltr)} # ["   A", "  B ", ...]
      .map {|line| line + line.chop.reverse + "\n"}                                 # ["   A   ", "  B  B  ", ...]

    #
    # Now copy and append (in reverse order) all lines except the last (which
    # will now be the middle line), and then join them all and return:
    #
    (top_half + top_half.reverse.drop(1)).join
  end
end
