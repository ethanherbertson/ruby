# This one is ugly... need to second-pass it
class Game
  @score

  attr_accessor :frame_num
  attr_accessor :roll_num

  attr_accessor :prev_pins
  attr_accessor :prev_prev_pins

  attr_accessor :prev_frame
  attr_accessor :prev_prev_frame

  def initialize
    @score = 0
    self.frame_num = 1
    self.roll_num = 1
    self.prev_pins = 0
    self.prev_prev_pins = 0
  end

  def roll(pins)
    raise BowlingError if pins < 0 || pins > 10
    @score += pins
    if frame_num < 10
      @score += pins if prev_frame == :strike

      if roll_num == 1
        @score += pins if prev_prev_frame == :strike
        @score += pins if prev_frame == :spare
        if pins == 10
          self.prev_prev_frame = prev_frame
          self.prev_frame = :strike
          self.frame_num += 1
        else
          self.roll_num += 1
        end
      else
        raise BowlingError if pins + prev_pins > 10

        self.prev_prev_frame = prev_frame
        self.frame_num += 1
        self.roll_num = 1 # reset

        self.prev_frame = (pins + prev_pins == 10) ? :spare : :open
      end
    else
      if roll_num == 1
        @score += pins if prev_prev_frame == :strike
        @score += pins if prev_frame == :strike || prev_frame == :spare
      elsif roll_num == 2
        raise BowlingError if pins + prev_pins > 10 && prev_pins < 10
        @score += pins if prev_frame == :strike
      else
        raise BowlingError unless roll_num == 3
        raise BowlingError if prev_prev_pins != 10 && (prev_pins + prev_prev_pins) != 10
        raise BowlingError if prev_prev_pins == 10 && prev_pins < 10 && (pins + prev_pins) > 10
      end
      self.roll_num += 1
    end

    self.prev_prev_pins = prev_pins
    self.prev_pins = pins
  end

  class BowlingError < RuntimeError
  end

  def score
    raise BowlingError if frame_num < 10 || roll_num < 3
    raise BowlingError if roll_num == 3 && (prev_pins + prev_prev_pins >= 10)
    @score
  end
end
