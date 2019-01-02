module Alphametics
  def self.solve(puzzle)
    # If it looks wrong, don't even try:
    return {} if puzzle.delete('^A-Z =+') == ''

    #############################
    # WARNING: eval used below! #
    #############################

    used_letters = puzzle.delete('^A-Z').chars.uniq.sort
    letter_set = used_letters.join
    solution = {}
    leading_letters = puzzle.split(' ').reject {|s| s == '+' || s == '=='}.map {|s| s[0]}.uniq

    (0..9).to_a
      .permutation(used_letters.length) # worst case scenario is 3.6 million iterations
      .each do |permutation|
        coding = [letter_set, permutation.map(&:to_s).join]

        # Skip this permutation if a leading letter would be mapped to zero:
        next nil if leading_letters.any? {|l| l.tr(*coding) == '0'}

        valid = eval puzzle.tr(*coding)

        if valid
          # if this is a second solution, give up now and return {}
          break nil unless solution.empty?

          solution = used_letters.zip(permutation).to_h
        end
      end

    solution
  end
end
