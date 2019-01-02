class Series
  def initialize(str)
    raise ArgumentError unless str.delete('0-9').empty?
    @nums = str.chars.map(&:to_i)
  end
  def largest_product(length)
    return 1 if length == 0 # as per tests

    raise ArgumentError if @nums.length < length

    @nums.each_cons(length)               # Enumerate all subarrays of the given length
      .map {|slice| slice.reduce(1, :*)}  # Calculate the product of each subarray
      .max                                # Return the largest such product
  end
end
