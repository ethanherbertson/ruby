module PerfectNumber
  def self.classify(n)
    raise RuntimeError unless n.integer? && n > 1

    # Brute force is fine; all *significant* optimizations are... hard.
    # (Doing each sum ourselves would let us early-out for 'abundant' cases,
    # but such cases are quite rare.)
    case n <=> (1...n).select {|f| n.modulo(f) == 0}.sum
      when +1 then 'deficient'
      when -1 then 'abundant'
      else 'perfect'
    end
  end
end
