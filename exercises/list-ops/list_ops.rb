#
# Implementing these behaviors yourself is, of course, a ludicrous thing to do
# in Ruby.
#
# The "rules" are to not use "existing functions"... but I pretty much have to
# use .length to know when an Array "ends". There are other ways to do it (e.g.
# calling .each and counting), but all of them I've thought of involve calling
# some *OTHER*, higher-level function, and they're all also slower than just
# calling .length.
#
module ListOps
  # Also aliased, reluctantly, as "arrays"
  def self.length(ary)
    ary.length # see above. I allow myself this one.
  end

  # Helper function. Like standard reduce, but always requires an explicit initial
  # value:
  def self.reducer(ary, init)
    last_index = length(ary) - 1
    for i in 0..last_index
      init = yield(init, ary[i])
    end
    init
  end

  def self.reverser(ary)
    reducer(ary, [], &:unshift)
  end

  def self.concatter(a, b)
    reducer(b, a, &:push)
  end

  def self.mapper(ary)
    reducer(ary, []) do |memo, el|
      memo.push(yield el)
    end
  end

  def self.filterer(ary)
    reducer(ary, []) do |memo, el|
      yield(el) ? memo.push(el) : memo
    end
  end

  def self.sum_reducer(ary)
    reducer(ary, 0, &:+)
  end

  # Also aliased, reluctantly, as "factorial_reducer"
  def self.product_reducer(ary)
    reducer(ary, 1, &:*)
  end

  # Provide aliases with the terrible names the tests expect:
  class <<self
    alias_method :arrays, :length
    alias_method :factorial_reducer, :product_reducer
  end
end
