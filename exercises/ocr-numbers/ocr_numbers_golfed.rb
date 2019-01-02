module OcrNumbers
  D = [' _ | ||_|', '     |  |', ' _  _||_ ', ' _  _| _|', '   |_|  |',
       ' _ |_  _|', ' _ |_ |_|', ' _   |  |', ' _ |_||_|', ' _ |_| _|'].map{|s| s + '   '}
  def self.convert(s)
    l = s.split("\n")
    raise ArgumentError if l.length % 4 != 0 or l.any? { |l| l.length % 3 != 0 }
    l.each_slice(4)
     .map { |q| p = q.map { |l| l.scan(/.../) } ; p.shift.zip(*p).map(&:join) }
     .map { |r| r.map { |v| D.find_index(v) || '?' }.join }.join(',')
  end
end
