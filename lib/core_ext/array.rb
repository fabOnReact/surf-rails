module Array::Forecast
  def minMaxString
    collect {|x| x["value"].round }.minmax.uniq.join("-")
  end

 def average
   sum = self.inject { |sum, el| sum + el }.to_f
   (sum / self.size).round(1)
 end

 def collectValues
   collect {|x| x["value"] }
 end

 def collectWaveHeights
   collect do |x| 
     row = x["waveHeight"]
     if block_given?; yield(row); else; row; end
   end
 end
end
