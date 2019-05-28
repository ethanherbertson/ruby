require 'minitest/autorun'
require 'timeout'
require_relative 'prime_factors'

class PrimeFactorsTest < Minitest::Test
  def test_1
    assert_equal [], PrimeFactors.for(1)
  end

  def test_2
    # skip
    assert_equal [2], PrimeFactors.for(2)
  end

  def test_3
    # skip
    assert_equal [3], PrimeFactors.for(3)
  end

  def test_4
    # skip
    assert_equal [2, 2], PrimeFactors.for(4)
  end

  def test_6
    # skip
    assert_equal [2, 3], PrimeFactors.for(6)
  end

  def test_8
    # skip
    assert_equal [2, 2, 2], PrimeFactors.for(8)
  end

  def test_9
    # skip
    assert_equal [3, 3], PrimeFactors.for(9)
  end

  def test_27
    # skip
    assert_equal [3, 3, 3], PrimeFactors.for(27)
  end

  def test_625
    # skip
    assert_equal [5, 5, 5, 5], PrimeFactors.for(625)
  end

  def test_901255
    # skip
    assert_equal [5, 17, 23, 461], PrimeFactors.for(901_255)
  end

  def test_93819012551
    # skip
    assert_equal [11, 9539, 894_119], PrimeFactors.for(93_819_012_551)
  end

  # These last two can take awhile if you don't have square-root optimizations:
  def test_plausibility_for_many_n
    Timeout.timeout(10) do
      assert (200_000..250_000).all? {|n| n = PrimeFactors.for(n).reduce(&:*)}
    end
  end

  def test_258518151547931337
    Timeout.timeout(10) do
      assert_equal [3, 61, 8377, 168_636_444_407], PrimeFactors.for(258_518_151_547_931_337)
    end
  end
end
