module Bob
  def self.hey(remark)
    yelled = true if remark == remark.upcase && remark != remark.delete('A-Z')
    question = true if remark.rstrip.end_with?('?')

    return 'Fine. Be that way!' if remark.strip.empty? # nothing said
    return "Calm down, I know what I'm doing!" if yelled && question
    return 'Whoa, chill out!' if yelled
    return 'Sure.' if question

    'Whatever.'
  end
end
