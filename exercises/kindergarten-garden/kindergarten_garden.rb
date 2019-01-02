class Garden
  DEFAULT_ROSTER = %w(Alice Bob Charlie David Eve Fred Ginny Harriet Ileana Joseph Kincaid Larry)
  PLANTS = {
    'C' => :clover,
    'G' => :grass,
    'R' => :radishes,
    'V' => :violets
  }

  def initialize(diagram, students = DEFAULT_ROSTER)
    @roster = students.sort.map(&:downcase)
    @first_row = diagram.lines[0]
    @second_row = diagram.lines[1]

    #
    # Build our dynamically-named, instance-specific accessor methods:
    #
    @roster.map(&:to_sym).each_with_index do |student, idx|
      #
      # NOTE: If we used define_method here, then each new Garden will still
      # have methods named after previous Gardens' students, even if those
      # students aren't in the new Garden's roster.
      #
      # By using define_singleton_method instead, we only create these
      # methods for the current instance of Garden.
      #
      define_singleton_method(student) do
        offset = idx * 2
        [
          PLANTS[@first_row[offset]],
          PLANTS[@first_row[offset + 1]],
          PLANTS[@second_row[offset]],
          PLANTS[@second_row[offset + 1]]
        ]
      end
    end
  end
end
