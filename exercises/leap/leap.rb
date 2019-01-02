module Year
  def self.leap?(year)
    return false if year.modulo(4) != 0   # e.g. 1997
    return true if year.modulo(100) != 0  # e.g. 2008

    year.modulo(400) == 0
  end
end
