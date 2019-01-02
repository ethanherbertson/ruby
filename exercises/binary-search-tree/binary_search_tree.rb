class Bst
  attr_accessor :data, :left, :right
  def initialize(first_value)
    @data = first_value
  end

  # Recursion here is less than ideal, the stack is not infinite...
  def insert(new_value)
    if new_value <= @data
      if @left.nil?
        @left = Bst.new(new_value)
      else
        @left.insert(new_value)
      end
    else
      if @right.nil?
        @right = Bst.new(new_value)
      else
        @right.insert(new_value)
      end
    end
  end

  # Recursion here is less than ideal, the stack is not infinite...
  def each
    return enum_for(:each) unless block_given? # return an enumerator for this behavior if we weren't given a block

    @left.each {|v| yield v} unless @left.nil?
    yield @data
    @right.each {|v| yield v} unless @right.nil?
  end
end
