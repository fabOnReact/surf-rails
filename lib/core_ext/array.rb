module Array::Forecast
  def minMaxString
    collect {|x| x["value"].round }.minmax.uniq.join("-")
  end
end
