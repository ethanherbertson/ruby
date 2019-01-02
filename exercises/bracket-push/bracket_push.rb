module Brackets
  MATCHING_PAIRS = {
    '[' => ']',
    '{' => '}',
    '(' => ')',
  }.freeze
  CHARS_TO_DELETE = ('^' + MATCHING_PAIRS.to_a.join).freeze

  def self.paired?(str)
    str.delete(CHARS_TO_DELETE).chars.reduce([]) do |stack, c|
      next stack.push(c) if MATCHING_PAIRS.keys.include?(c) # We're opening a new pair, push it onto stack and move on
      next stack if c == MATCHING_PAIRS[stack.pop]          # We're closing an old pair, pop the opener from stack and move on
      return false                                          # We're closing a pair that didn't exist, so we can't be "paired"
    end.empty?                                              # At this point we're "paired" if and only if no openers were left
  end
end
