class Anagram
  @canonical
  @anagrammed

  def initialize(word)
    @canonical = word.downcase
    @anagrammed = @canonical.chars.sort
  end

  # True if an anagram, unless it's the same word
  def is_anagram?(word)
    @anagrammed == word.downcase.chars.sort && @canonical != word.downcase
  end

  def match(wordlist)
    wordlist.select {|w| is_anagram?(w)}
  end
end
