require 'core_ext/array'

class Forecast < Array
  Array.include(Array::Weather)
  Hash.include(Hash::Weather)
  def current
    @current ||= select {|row| row["time"] == timeNow }.first
  end

  def timeNow
    DateTime.now.utc.in_time_zone(-1).beginning_of_hour.xmlschema
  end

  def days
    upcoming.map {|x| x["time"] }[0..152]
  end

  def upcoming
    select { |row| row["time"] >= timeNow }
  end

  def select
    Forecast.new(super)
  end

  def values
    collect {|x| x["value"] }
  end

  def time; 
    current["time"]; 
  end

  def collectValues(key)
    collect do |x| 
      row = Forecast.new(x[key])
      if block_given?; yield(row); else; row; end
    end
  end
end
