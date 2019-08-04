module Array::Weather
  def minMaxString
    collect {|x| x["value"].round }.minmax.uniq.join("-")
  end

  def average
    sum = self.inject { |sum, el| sum + el }.to_f
    (sum / self.size).round(1)
  end
end
