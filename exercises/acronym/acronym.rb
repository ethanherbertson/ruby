module Acronym
  def self.abbreviate(phrase)
    phrase.split(/[ -]+/) # split---on hyphens and whitespace---into an array of "words"
      .map(&:chr)         # convert to array of the first letter from each "word"
      .map(&:upcase)      # make those letters uppercase
      .join               # join the letters into a single string and return
  end
end
