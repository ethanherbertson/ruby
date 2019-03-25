require 'matrix'
class Robot
  attr_reader :position_vector, :bearing_vector

	BEARINGS = {														 #      north (+y)
		north: Matrix.column_vector([ 0, +1]), #			  ^
		east:  Matrix.column_vector([+1,  0]), # west <   > east (+x)
		south: Matrix.column_vector([ 0, -1]), #        v
		west:  Matrix.column_vector([-1,  0]), #      south
	}
	BEARING_LOOKUP = BEARINGS.invert

	CW_ROTATION = Matrix[[0, 1], [-1, 0]]
	CCW_ROTATION = Matrix[[0, -1], [1, 0]]

  def initialize
    @position_vector = Matrix.column_vector([0, 0])
  end

  def orient (direction)
    raise ArgumentError if BEARINGS[direction].nil?
    @bearing_vector = BEARINGS[direction]
  end

  def turn_right
    @bearing_vector = CW_ROTATION * self.bearing_vector
  end

  def turn_left
    @bearing_vector = CCW_ROTATION * self.bearing_vector
  end

  def at(x,y)
    @position_vector = Matrix.column_vector([x, y])
  end

	def coordinates
		self.position_vector.column(0).to_a
	end

	def bearing
		BEARING_LOOKUP[self.bearing_vector]
	end

  def advance
    @position_vector = self.position_vector + self.bearing_vector
  end
end

class Simulator
  COMMANDS = {
    'L' => :turn_left,
    'R' => :turn_right,
    'A' => :advance,
  }
  def instructions(tape)
    COMMANDS.fetch_values(*tape.upcase.chars) # req ruby 2.3
  end

  def place(robot, x:, y:, direction:)
    robot.at(x, y)
    robot.orient(direction)
  end

  def evaluate(robot, tape)
    instructions(tape).each do |command|
      robot.method(command).call
    end
  end
end
