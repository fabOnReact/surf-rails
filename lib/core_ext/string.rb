module String::Transformations
  def duckTyped
    self.split(/(?=[A-Z])/).join("_").downcase  
  end
end
