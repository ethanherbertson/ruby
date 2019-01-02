module Isogram
  def self.isogram?(string)
    found = {}
    string
      .downcase                                 # Normalize case, then
      .delete('^a-z')                           # Ignore everything but ascii letters, then
      .chars                                    # Convert it to an array, then
      .all? {|char| found[char] = !found[char]} # Make sure all letters in the array are found only once
  end
end
