# Warning, this isn't known to terminate (at least not for large integers)!
module CollatzConjecture
  def self.steps(start)
    raise ArgumentError if start <= 0

    out = 0

    while start != 1
      out += 1
      start = start.even? ? start / 2 : (3 * start) + 1
    end

    out
  end
end
