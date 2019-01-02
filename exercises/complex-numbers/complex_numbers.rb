# This should probably inherit from Numeric, but Numeric is for immutable,
# non-instantiated objects, and the tests as-written presume a .new()
# constructor.
require 'bigdecimal'
require 'bigdecimal/math'
include BigMath
class ComplexNumber
  attr_reader :real
  attr_reader :imaginary
  def initialize(real, imaginary)
    @real      = real.is_a?(Float)      ? BigDecimal.new(real, Float::DIG)      : BigDecimal.new(real)
    @imaginary = imaginary.is_a?(Float) ? BigDecimal.new(imaginary, Float::DIG) : BigDecimal.new(imaginary)
  end
  def +(other)
    ComplexNumber.new(
      real + other.real,
      imaginary + other.imaginary
    )
  end
  def *(other)
    ComplexNumber.new(
      real * other.real - (imaginary * other.imaginary),
      real * other.imaginary + (imaginary * other.real)
    )
  end
  def ==(rhs)
    rhs.respond_to?(:real) && rhs.respond_to?(:imaginary) && rhs.real == real && rhs.imaginary == imaginary
  end
  def conjugate
    ComplexNumber.new(real, -1 * imaginary)
  end
  def reciprocal
    raise ZeroDivisionError if real == 0 && imaginary == 0
    ComplexNumber.new(
      real / (real ** 2 + imaginary ** 2),
      -1 * imaginary / (real ** 2 + imaginary ** 2)
    )
  end
  def abs
    (real ** 2 + imaginary ** 2) ** 0.5
  end
  def exp
    # TODO: The rounding here is to protect against floating-point math errors
    # that are occurring... need to investigate
    ComplexNumber.new(BigMath.exp(real, 4 * Float::DIG).round(Float::DIG-1), 0) *
      ComplexNumber.new(
        BigMath.cos(imaginary, 4 * Float::DIG).round(Float::DIG-1),
        BigMath.sin(imaginary, 4 * Float::DIG).round(Float::DIG-1)
      )
  end
  def -(other)
    self + (ComplexNumber.new(-1,0) * other)
  end
  def /(other)
    self * other.reciprocal
  end
end
