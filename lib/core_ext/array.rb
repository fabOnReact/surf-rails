module Array::Forecast
  def minMaxString
    collect {|x| x["value"] }.minmax.join("-")
  end
end
