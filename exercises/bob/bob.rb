module Bob
  def self.hey(remark)
    return 'Fine. Be that way!' if remark.strip.empty?

    is_yelling = (remark == remark.upcase && remark.match(/[a-zA-Z]/))
    is_question = remark.strip.end_with?('?')

    return 'Calm down, I know what I\'m doing!' if is_yelling && is_question
    return 'Sure.' if is_question
    return 'Whoa, chill out!' if is_yelling

    'Whatever.'
  end
end
