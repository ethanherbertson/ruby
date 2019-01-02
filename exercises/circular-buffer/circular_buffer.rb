class CircularBuffer
  @buf
  @current_read
  @current_write
  @count
  def initialize(size)
    @buf = Array.new(size)
    @current_read = 0
    @current_write = 0
    @count = 0
  end

  def write(val)
    raise BufferFullException if @count == @buf.size
    write!(val)
  end

  def write!(val)
    @buf[@current_write] = val
    @current_write = (@current_write + 1).modulo(@buf.size)

    if @count == @buf.size
      # Advance read pointer so that it points to the oldest thing left in the
      # buffer, instead of to the previously oldest thing, which has now been
      # freshly overwritten:
      @current_read = (@current_read + 1).modulo(@buf.size)
    else
      @count += 1
    end
    nil
  end

  def read
    raise BufferEmptyException if @count == 0
    out = @buf[@current_read]
    @current_read = (@current_read + 1).modulo(@buf.size)
    @count -= 1
    out
  end

  def clear
    @current_read = @current_write
    @count = 0
  end

  class BufferFullException < RuntimeError
  end
  class BufferEmptyException < RuntimeError
  end
end
