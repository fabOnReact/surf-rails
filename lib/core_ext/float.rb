module Float::Coordinates
  def in_word
    case self
    when 0..30
      "North"
    when 30..60
      "NorthEast"
    when 60..120
      "East"
    when 120..150
      "SouthEast"
    when 150..210
      "South"
    when 210..240
      "SouthWest"
    when 240..300
      "West"
    when 300..330
      "NorthWest"
    when 330..360
      "North"
    end
  end
end
