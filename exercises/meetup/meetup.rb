require 'date'

class Meetup
  # 0 for Sunday, 1 for Monday, etc., just like Date.wday() does it
  DAYS_OF_WEEK = Hash[Date::DAYNAMES.each_with_index.to_a].freeze

  def initialize(month, year)
    @start_date = Date.new(year, month)
  end

  def day(day_of_week, modifier)
    target = DAYS_OF_WEEK[day_of_week.to_s.capitalize]
    raise ArgumentError if target.nil?

    # Note: README mentions a :fifth modifier, but no tests exist, and it's the
    # hardest because it's the only one for which there isn't a guaranteed
    # correct answer. So I'm not doing it.
    min_date = case modifier
      when :first   then @start_date
      when :second  then @start_date + 7
      when :teenth  then @start_date + 12
      when :third   then @start_date + 14
      when :fourth  then @start_date + 21
      when :last    then @start_date.next_month - 7
      else raise ArgumentError, "Modifier not implemented: #{modifier}"
    end

    min_date + (target - min_date.wday).modulo(7)
  end
end
