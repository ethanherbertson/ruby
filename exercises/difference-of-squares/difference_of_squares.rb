class Squares
  def initialize(n)
    @n = n
  end
  def square_of_sum
    # (n · (n + 1) / 2)²
    # based on closed form, knew it already
    @square_of_sum ||= ((@n * (@n + 1)) / 2) ** 2
  end
  def sum_of_squares
    # n · (n + 1) · (2n + 1) / 6
    # closed form, had forgotten it but looked it up:
    @sum_of_squares ||= (@n * (@n + 1) * ((2 * @n) + 1)) / 6
  end
  def difference
    @difference ||= square_of_sum - sum_of_squares
  end
end
