module IsbnVerifier
  def self.valid?(string)
    normalized = string.delete('-')
    return false unless normalized.match(/^\d{9}[\dX]$/)

    sum = normalized.chars.each_with_index.reduce(0) do |memo, (char, index)|
      memo + ((char == 'X' ? 10 : char.to_i) * (10 - index))
    end

    sum.modulo(11) == 0
  end
end
