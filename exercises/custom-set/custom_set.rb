# NOTE: Ruby ships with a Set library for this stuff, but that's no fun.
# Also NOTE: Like that Set library, this implementation assumes elements don't mutate.
class CustomSet
  def initialize(ary)
    @h = ary.uniq.zip([]).to_h
  end
  def empty?
    @h.empty?
  end
  def member?(el)
    @h.key?(el)
  end
  def members
    @h.keys
  end
  def subset?(cs)
    members.all? {|el| cs.member?(el)}
  end
  def disjoint?(cs)
    members.none? {|el| cs.member?(el)}
  end
  def ==(cs)
    @h == cs.members.zip([]).to_h # could also do (union - intersect) == empty-set... but this is probably cheaper
  end
  def add(el)
    @h[el] = nil
    self
  end
  def intersection(cs)
    CustomSet.new(members & cs.members) # array method is nicer than doing .select
  end
  def difference(cs)
    CustomSet.new(members - cs.members) # array method is nicer than doing .filter
  end
  def union(cs)
    CustomSet.new(members + cs.members)
  end
end
