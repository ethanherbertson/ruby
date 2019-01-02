class BinarySearch
  attr_accessor :list
  def initialize(list)
    self.list = list
    raise ArgumentError if list.each_index.drop(1).any? { |i| list[i] <= list[i-1] }
  end

  # Why is this part of the public interface?
  def middle(min: 0, max: self.list.length)
    ((max - min) / 2) + min # "rounds down"
  end

  def search_for(item)
    min = 0
    max = self.list.length

    loop do
      middle = self.middle(min: min, max: max)
      candidate = self.list[middle]

      return middle if item == candidate

      # If middle == min, then either max == min or max == min + 1.
      # In either case, we've either tested list[max] already, or it's still
      # out of bounds (@list.length)... therefore we've run out of places where
      # `item` might appear in the list.
      raise RuntimeError if middle == min

      if item < candidate
        max = middle
      else
        min = middle
      end
    end
  end
end
