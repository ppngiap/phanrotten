module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end

  # @param s [String]
  def sort_by(s)
    movies_path + "?sort_by=#{s}"
  end
end
