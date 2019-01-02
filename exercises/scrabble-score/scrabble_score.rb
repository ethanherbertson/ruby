# (Solution created in group workshop with Thomas Crosby and Venkat Alla)
class Scrabble
  CONFIG = {
     1 => %w(A E I O U L N R S T ),
     2 => %w(D G                 ),
     3 => %w(B C M P             ),
     4 => %w(F H V W Y           ),
     5 => %w(K                   ),
     8 => %w(J X                 ),
    10 => %w(Q Z                 )
  }.freeze
  SCORES = CONFIG.each_pair
                 .reduce({}) {|scores,(k,v)| v.each {|letter| scores[letter] = k}; scores}
                 .freeze

  def initialize(word)
    @word = word || ''
  end

  def score
    @score ||= @word.chars.map(&:upcase).map {|c| SCORES[c] || 0}.reduce(&:+) || 0
  end

  def self.score(word)
    self.new(word).score
  end
end
