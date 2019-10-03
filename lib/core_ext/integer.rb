module Integer::Transformations
  def next_day
    next_day = self + 2
    next_day -= 6 if next_day > 6
    next_day
  end
end
