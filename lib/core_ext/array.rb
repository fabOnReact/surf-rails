module Array::Calculations
  def minMaxString
    collect { |x| x["value"].round }.minmax.uniq.join("-")
  end

  def average
    return if self.empty?
    total = self.inject { |sum, el| sum + el }.to_f
    (total / self.size).round(1)
  end

  def in_words
    map do |date|
      date.to_datetime.strftime("%A")
    end
  end
end
