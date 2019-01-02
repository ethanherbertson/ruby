# Honestly the tests don't specify any methods that aren't already efficiently
# implemented by Array, so we should really just:
#
# class Deque < Array
# end
#
# ... But that's not really in the spirit of things, so:
class Deque
  include Enumerable # Bonus points! Requires an each() method, and the elements to have an <=> operator.

  class Deque::El
    attr_accessor :v, :prv, :nxt
    def initialize(v, p=nil, n=nil)
      self.v = v
      self.prv = p
      self.nxt = n
    end
    def <=>(other) # Necessary for some Enumerable methods to work
      self.v <=> other.v
    end
  end

  @head
  @tail

  def initialize
    @head = nil
    @tail = nil
  end

  def push(obj)
    element = Deque::El.new(obj)
    if @tail
      element.prv = @tail
      @tail.nxt = element
      @tail = element
    else
      @tail = element
      @head = element
    end
    self
  end

  def pop
    return nil unless @tail
    element = @tail
    @tail = element.prv
    @tail.nxt = nil if @tail
    element.v
  end

  def unshift(obj)
    element = Deque::El.new(obj)
    if @head
      element.nxt = @head
      @head.prv = element
      @head = element
    else
      @head = element
      @tail = element
    end
    self
  end

  def shift
    return nil unless @head
    element = @head
    @head = element.nxt
    @head.prv = nil if @head
    element.v
  end

  def each # Necessary for basically all Enumerable methods to work
    return enum_for(:each) unless block_given? # return an enumerator if we weren't given a block
    curr = @head
    while curr
      yield curr.v
      curr = curr.nxt
    end
  end
end
