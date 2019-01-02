class School
  def initialize
    # Start each grade with a new empty array:
    @grades = Hash.new { |hash, grade| hash[grade] = [] }
  end

  def students(grade)
    #
    # We could store them sorted instead (maybe in a SortedSet?). But we'd
    # want to return a copy anyway, to prevent external code from editing
    # the internal structure, so the performance hit isn't really all that
    # big. Also for a school large enough for performance to actually matter,
    # we should use a proper database anyway.
    #
    @grades[grade].sort
  end

  def add(student, grade)
    #
    # We copy and freeze the student before storing them, so that external
    # code can't edit it later.
    #
    # We also avoid returning the array itself, for the same reason.
    # (But why DOES the test expect a truthy return? Seems arbitrary.)
    #
    @grades[grade].push(String.new(student).freeze)
    true
  end

  def students_by_grade
    @grades.keys.sort.map {|grade| {grade: grade, students: self.students(grade)}}
  end
end
