class Clock
  MAXTIME = 24 * 60
  @time
  def initialize(hour: 0, minute: 0)
    @time = ((hour * 60) + minute).modulo(MAXTIME)
  end

  def to_s
    format('%02d:%02d', *self.to_a)
  end

  def +(other)
    h, m = (raw + other.raw).modulo(MAXTIME).divmod(60)
    Clock.new(hour: h, minute: m)
  end

  def -(other)
    h, m = (raw - other.raw).modulo(MAXTIME).divmod(60)
    Clock.new(hour: h, minute: m)
  end

  def ==(other)
    self.raw == other.raw
  end

  # undocumented:

  def to_a
    @time.divmod(60)
  end

  def raw
    @time
  end
end
