module Board
  # TODO this is pretty gross
  def self.transform(board_lines)
    board_lines = board_lines.dup # prevent side-effects

    raise ArgumentError, "Invalid board, inconsistent width" if board_lines.map(&:length).uniq.length != 1

    # remove pointless top and bottom border
    first_line = board_lines.shift
    last_line = board_lines.pop

    raise ArgumentError, "Invalid board, first-last mismatch" if first_line != last_line
    raise ArgumentError, "Invalid board, invalid top border" unless first_line.match(/^\+-+\+$/)
    raise ArgumentError, "Invalid board, invalid middle lines" unless board_lines.all? {|l| l.match(/^\|[* ]+\|$/)}

    # remove pointless left and right borders
    board_lines.each {|l| l.delete!('|')}

    # Define a 2d array for us to count hits in, initializing all entries to 0.
    # We add an extra row and column to prevent wrap-around indexing issues.
    counts = Array.new(board_lines.length + 1) do |_|
      Array.new(board_lines.first.length + 1, 0)
    end

    # Now do the counting. Copy over any actual mines, since we don't report
    # counts for those cells.
    board_lines.each_with_index do |line, row|
      line.chars.each_with_index do |char, col|
        next unless char == '*'

        counts[row][col] = '*'

        counts[row - 1][col    ] += 1 unless counts[row - 1][col    ] == '*'
        counts[row - 1][col - 1] += 1 unless counts[row - 1][col - 1] == '*'
        counts[row - 1][col + 1] += 1 unless counts[row - 1][col + 1] == '*'
        counts[row    ][col - 1] += 1 unless counts[row    ][col - 1] == '*'
        counts[row    ][col + 1] += 1 unless counts[row    ][col + 1] == '*'
        counts[row + 1][col    ] += 1 unless counts[row + 1][col    ] == '*'
        counts[row + 1][col - 1] += 1 unless counts[row + 1][col - 1] == '*'
        counts[row + 1][col + 1] += 1 unless counts[row + 1][col + 1] == '*'
      end
    end

    counts.slice(0...-1)                      # slice off the last row, which was a gutter
      .map do |line|                          # for the remaining lines:
        line.map {|c| c == 0 ? ' ' : c.to_s}  #   convert 0s to spaces, and all other numbers to strings
            .join                             #   join the one-character strings into a whole line
            .chop                             #   chop off the last character of the line, which was a gutter
            .prepend('|')                     #   add the left border
            .concat('|')                      #   add the right border
      end                                     #
      .unshift(first_line)                    # add back the top border
      .push(last_line)                        # add back the bottom border
  end
end
