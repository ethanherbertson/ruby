module Atbash
  ALPHABET = ('a'..'z').to_a.freeze
  SOURCE = ('0'..'9').to_a.push(*ALPHABET).join.freeze
  TARGET = ('0'..'9').to_a.push(*ALPHABET.reverse).join.freeze

  def self.encode(pt)
    format(canonicalize(pt).tr(SOURCE,TARGET))
  end

  # privates:

  def self.canonicalize(s)
    s.downcase.delete('^' + SOURCE)
  end

  def self.format(s)
    s.scan(/.{1,5}/).join(' ')
  end

  private_class_method :canonicalize, :format
end
