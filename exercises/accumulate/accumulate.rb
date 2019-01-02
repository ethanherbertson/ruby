module Enumerable
  def accumulate
    unless block_given?
      return itself.to_enum(__method__) do
        itself.size
      end
    end

    # They said not to do it this way, for some reason:
    # itself.map do |e|
    #   yield e
    # end

    out = []
    itself.each do |e|
      out.push(yield e)
    end
    out
  end
end
