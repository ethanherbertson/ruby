class Matrix
  # I chose to make access via both row and column constant-time. The simple and
  # lazy way to this is probably best: Store row-wise initially, generate the
  # column-wise representation when first accessed and memoize it.
  #
  # We freeze the representations because naively allowing mutations can lead
  # to length mismatches, disagreements between the two representations, and
  # other bad things.
  @mat_by_rows
  @dirty

  def initialize(matrix_string)
    @mat_by_rows = matrix_string.lines.map {|line| line.split(' ').map(&:to_i)}.freeze
    @dirty = true
  end

  def rows
    @mat_by_rows
  end

  def columns
    if @dirty
      @mat_by_cols = @mat_by_rows.transpose.freeze
      #
      # Or, if we're denying ourselves that kind of nicety:
      #
      #   @mat_by_cols = @mat_by_rows.first.map {|n| [n]}
      #   @mat_by_rows.drop(1).each do |row|
      #     row.each_with_index {|n, idx| @mat_by_cols[idx].push(n)}
      #   end
      #   @mat_by_cols.freeze
      #
      @dirty = false
    end
    @mat_by_cols
  end
end
