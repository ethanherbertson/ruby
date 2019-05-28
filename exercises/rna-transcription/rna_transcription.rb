module Complement
  DNA_TO_RNA = {'A' => 'U', 'C' => 'G', 'G' => 'C', 'T' => 'A'}.freeze

  def self.of_dna(dna)
    return '' unless dna.delete(DNA_TO_RNA.keys.join) == ''
    DNA_TO_RNA.values_at(*dna.chars).join
  end
end
