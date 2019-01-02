module ETL
  def self.transform(obj)
    obj.each_pair
       .map {|(k,v)| [k, v.map(&:downcase)]}
       .reduce({}) {|scores,(k,v)| v.each {|letter| scores[letter] = k}; scores}
       .freeze
  end
end
