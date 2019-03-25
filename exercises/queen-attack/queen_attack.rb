class Queens
  # The tests allow black to be unspecified. Weird.
  def initialize(white: [], black: [])
    raise ArgumentError unless (white + black).all? {|n| (0..7).cover?(n)}
    @white = white
    @black = black
  end

  def attack?
    x_diff = (@white.first - @black.first).abs
    y_diff = (@white.last - @black.last).abs

    # true if on same col, same row, or same diagonal:
    (x_diff == 0) || (y_diff == 0) || (x_diff == y_diff)
  end
end
