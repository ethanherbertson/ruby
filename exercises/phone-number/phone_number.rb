module PhoneNumber
  def self.clean(dirty_number)
    # get array of the digits from the number:
    digits = dirty_number.delete('^0-9').chars

    # error if it's not one of the expected lengths:
    return unless (10..11).cover?(digits.length)

    # if it's 11 digits, it better start with a '1' (which we ignore):
    if digits.length == 11
      return unless digits.shift == '1' # checks AND removes it
    end

    # neither the area code nor the exchange can start with a 1 or a 0:
    return unless ('2'..'9').cover?(digits[0])
    return unless ('2'..'9').cover?(digits[3])

    digits.join
  end
end
