module Grains
  SQUARES = 64 # In case someone invents a better chessboard
  TOTAL = (2 ** SQUARES) - 1 # Sum of powers of two upto N is always (2 ** N) - 1: 1, 3, 7, 15, etc.

  def self.square(sq)
    raise ArgumentError if sq < 1 || sq > SQUARES
    2 ** (sq - 1)
  end

  def self.total
    TOTAL
  end
end
