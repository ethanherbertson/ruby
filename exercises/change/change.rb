#
# "Cheated" by looking up potential viable algorithm designs (though only
# in pseudocode).
#
# Below are my initial exploratory thoughts re: potential algorithms (all incomplete):
#
#   We're okay if 1 is a denomination, if not:
#     Set new array (or hash) equal to list of positive integers < smallest denomination.
#     Return -1 if target in that list.
#     Choose smallest two coprime denominations:
#       Calculate impossible "changes" using those two (only) (will all be <= pq - p - q)
#         Find smallest multiple of p, kp, such that kp = n mod q, for all n < q.
#         There will be exactly q such multiples, and they will all be < pq.
#         All m < kp s.t. m ≡ kp mod q are impossible with only those two denoms, make them the new list
#       While other denominations exist <= pq-p-q:
#         Find next smallest denomination, find its multiples mod p and q, or vice-versa if it is larger
#         Detect
#     If demoninations ALL share a common divisor, then infinite number of impossible targets!
#
#   ...
#
#   If zero denoms, return -1
#   If one denom, check if target is multiple and if not return -1, else return quotient
#   Else
#     Look for two coprime denoms
#
#   ...
#
#   For given two scores:
#     Divide-out and remember the gcd (if > 1)
#
module Change
  ERROR_CODE = -1 # this is not a good way to denote errors...
  def self.generate(denoms, target)
    denoms = denoms.sort.uniq # prevent extra work (and potential side-effects)

    return ERROR_CODE if denoms.any? {|d| d <= 0} || target < 0
    return [] if target == 0 # trivial case

    @found_solutions = {} # need some state for recursion to work

    min_coins(denoms, target) || ERROR_CODE
  end

  # recursive method, returns false if impossible
  # TODO: Make this non-recursive to prevent stack overflow!
  # TODO: Make this tail-recursive, failing that
  def self.min_coins(denoms, target)
    result_set = @found_solutions[target]
    return result_set if result_set

    result_set = false if result_set.nil?

    if denoms.include?(target)
      @found_solutions[target] = [target]
      return [target]
    end

    fewest_so_far = nil

    possible_denoms = denoms.select {|d| d < target}
    possible_denoms.each do |denom|
      intermediate_solution = min_coins(possible_denoms, target - denom)
      next unless intermediate_solution

      if fewest_so_far.nil? || intermediate_solution.length + 1 < fewest_so_far
        fewest_so_far = intermediate_solution.length + 1
        result_set = (intermediate_solution + [denom]).sort
      end
    end

    @found_solutions[target] = result_set # memoize so we don't repeat our work
    result_set
  end

  private_class_method :min_coins # unsafe to call with bad data
end
