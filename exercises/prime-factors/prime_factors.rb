module PrimeFactors
  def self.for(n)
    factorization = []
    factor = 2

    #
    # As long as we start small and work our way up, and as long as we actually
    # update our "n" to remove factors already found, we don't really have to
    # care about primality of the factors. The factors we find will naturally be
    # prime.
    #
    # We give up either when we reduce the remaining dividend to 1, or once
    # we've checked all numbers up to the square root of the remaining
    # dividend, since at that point the remaining dividend must be prime.
    #
    # (This is the "trial division" method. It's fine for small n.)
    #
    while n > 1 && (factor * factor <= n)
      # Check to see if it's a factor, if so add it to the list and reduce n.
      # Repeat until it's no longer a factor of the remaining n.
      while n.modulo(factor) == 0
        n /= factor
        factorization.push(factor)
      end
      factor += 1
    end

    #
    # If the remaining dividend is greater than 1, then we have tried all
    # factors up to its square root. Therefore it must be prime, and hence the
    # last remaining prime factor of n.
    #
    if n > 1
      factorization.push(n)
    end

    factorization
  end
end
