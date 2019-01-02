module House
  def self.recite
    #
    # Each stanza starts and ends the same way:
    #
    clauses = ['This is ', "the house that Jack built.\n"]

    output = clauses.join

    #
    # Each time we add a stanza, we build the requisite clause and insert it
    # in the stack, right after the "This is " at the beginning. The text
    # of each stanza, then, is a simple concatenation of all clauses so far.
    #
    [
      ['malt', 'lay in'],
      ['rat', 'ate'],
      ['cat', 'killed'],
      ['dog', 'worried'],
      ['cow with the crumpled horn', 'tossed'],
      ['maiden all forlorn', 'milked'],
      ['man all tattered and torn', 'kissed'],
      ['priest all shaven and shorn', 'married'],
      ['rooster that crowed in the morn', 'woke'],
      ['farmer sowing his corn', 'kept'],
      ['horse and the hound and the horn', 'belonged to'],
    ].each do |(noun, verb)|
      clauses.insert(1, "the #{noun}\nthat #{verb} ")
      output << "\n" << clauses.join
    end

    output
  end
end
