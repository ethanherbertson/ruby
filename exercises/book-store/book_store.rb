#
# This is a cleaned-up and streamlined version of a solution I wrote in
# collaboration with Alisher Sadikov, Eric Biven, and Stephen Graf
#
module BookStore
	COST_OF_SET = {
		0 => 0.0,
		1 => 8,
		2 => 15.2, # 16 delta = - 0.8
		3 => 21.6, # 24 delta = - 1.6
		4 => 25.6, # 32 delta = - 4
		5 => 30.0 # 40 delta = - 3.6
	}.freeze

  def self.calculate_price(book_list)
    cost = 0

		#
		# Count the number of copies of each book, and put them in
		# an array, sorted with the highest number of copies first:
		#
    tallies = book_list.reduce({1=>0, 2=>0, 3=>0, 4=>0, 5=>0}) do |acc, book|
			acc[book] += 1
			acc
		end.values.sort.reverse

		#
		# Calculate the number of sets of N books we have in our
		# shopping bag. (This method only works because tallies is
		# sorted with the highest tallies first.)
		#
		set_of_n = lambda { |n| n == 5 ? tallies[4] : (tallies[n-1] - tallies[n]) }

		#
		# Remove a set of N books from our tallies. The N-book set
		# is chosen so that it contains a copy of each of the books
		# with the top-N starting tallies.
		#
		remove_set_of_n = lambda { |n| tallies.map!.with_index { |t, i| i < n ? t - 1 : t } }

		#
		# A set of 5 and a set of 3 are, more expensive than the equivalent two sets
		# of 4. In all other situations, the "naive" approach of assigning books into
		# sets results in the cheapest possible cost; sets of 5 are preferred over
		# sets of 4, sets of 4 are preferred over sets of 3, etc. etc.
		#
		# To calculate the best price, then, we FIRST have to price all pairs of sets
		# of 5 and sets of 3 as a pair of sets of 4, and then remove those books from
		# the bag.
		#
    while set_of_n.call(5) > 0 && set_of_n.call(3) > 0
      cost += (COST_OF_SET[4] * 2)
      remove_set_of_n.call(5)
      remove_set_of_n.call(3)
    end

		#
		# Now that the two-fours-are-better-than-a-five-and-a-three case has been handled,
		# we can simply calculate how many sets of each size remain and price those accordingly:
		#
    for i in 1..5 do
      set_of_n.call(i).times do
        cost += COST_OF_SET[i]
        remove_set_of_n.call(i)
      end
    end

    cost
  end
end
