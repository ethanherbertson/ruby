class Affine
  # Establish what we're doing:
  ALPHABET = ('a'..'z').to_a.join.freeze
  PASSTHROUGH_CHARS = ('0'..'9').to_a.join.freeze

  # Calculate everything we can up-front:
  ALPHABET_SIZE = ALPHABET.length
  NUM_LOOKUP = ALPHABET.chars.zip(0..ALPHABET.length).to_h.freeze
  ALPHA_LOOKUP = NUM_LOOKUP.invert.freeze
  MEANINGLESS_CHARS = ('^' + ALPHABET.upcase + ALPHABET + PASSTHROUGH_CHARS).freeze

  @a
  @b
  @mmi

  def initialize(a, b)
    @a = a
    @b = b
    @mmi = mmi(a, ALPHABET_SIZE)
  end

  def encode(pt)
    pt.delete(MEANINGLESS_CHARS)        # Remove non-semantic characters
      .downcase                         # Lowercase it all
      .chars                            # Make an array of the characters
      .map { |c| encrypt_char(c) }      # Transmute
      .each_slice(5)                    # Group every five characters together in an array
      .map { |quint| quint.push(' ') }  # Add a space after each five-letter group
      .join                             # Join all the characters into a single string
      .chop                             # Remove the last ' ' we pushed
  end

  def decode(ct)
    ct.delete(MEANINGLESS_CHARS)        # Remove non-semantic characters
      .downcase                         # Lowercase it all
      .chars                            # Make an array of the characters
      .map { |c| decrypt_char(c) }      # Transmute
      .join                             # Join them all into a single string
  end

  def encrypt_char(character)
    return character unless character.match(/[#{ALPHABET}]/) # passthrough anything we can't convert
    ALPHA_LOOKUP[((@a * NUM_LOOKUP[character]) + @b).modulo(ALPHABET_SIZE)]
  end

  def decrypt_char(character)
    return character unless character.match(/[#{ALPHABET}]/) # passthrough anything we can't convert
    ALPHA_LOOKUP[(@mmi * (NUM_LOOKUP[character] - @b)).modulo(ALPHABET_SIZE)]
  end

  # Calculate the modular multiplicative inverse (there are faster
  # algorithms, but this is fine for small m):
  def mmi(a, m)
    raise ArgumentError, 'Error: a and m must be coprime.' if a.gcd(m) != 1
    (1..(m-1)).each do |multiplier|
      return multiplier if (a * multiplier).modulo(m) == 1
    end
  end
end
