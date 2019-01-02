class Crypto
  attr_reader :ciphertext # don't store plaintext in memory longer than we have to
  def initialize(plaintext)
		@ciphertext = ''

		return if plaintext == ''

		# normalize & turn into array
    plaintext = Util.normalize(plaintext).chars

    length = plaintext.length

		# Calculate the dimensions of our "square". Dimensions cannot
		# differ by more than 1, and should be as small as possible.
    r = Math.sqrt(length).floor
    if r * r == length
      c = r
    elsif r * (r + 1) >= length
      c = r + 1
    else
      r += 1
      c = r
    end

    spaces_to_add = Util.padding_length(plaintext, r) # could also use c here, because aiming for c*r

    plaintext = plaintext
      .concat([nil] * spaces_to_add) 			# pad with nils until we have (c * r) elements
      .each_slice(c).to_a                 # make a (r x c) two-dimensional array
      .transpose                          # make it a (c x r) 2-d array instead
      .flatten                            # flatten it down to a single array, in the new order
      .compact                            # remove the nils we added

		# Add the spaces starting at the last character, and then
		# every `r` characters (counting backwards) after that:
		(0...spaces_to_add).each do |i|
			plaintext.insert(-1 - (i * r), ' ');
		end

		# Slice the array of individual characters into an array
		# of arrays of `r` characters, then join the inner arrays
		# into strings, and then join those strings into one big
		# space-separated string:
		@ciphertext = plaintext.each_slice(r).map(&:join).join(' ')
  end

	module Util
		def self.normalize(text)
			text.downcase.delete('^a-z0-9')
		end
		def self.padding_length(text, column_width)
			mod = text.length.modulo(column_width)
			mod == 0 ? 0 : column_width - mod
		end
	end
end
