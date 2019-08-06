module String::Weather
  def duckTyped
    self.split(/(?=[A-Z])/).join("_").downcase  
  end
end
