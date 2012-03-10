module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end

#http://localhost:3000/movies?utf8=%E2%9C%93&ratings[G]=1&ratings[R]=1&ratings[PG-13]=1&commit=Refresh
  # @param s [String]
  def sort_by_with_ratings_path(s)
    ratings = ''
    if @ratings != nil
      @ratings.each do |k,v|
        ratings += "&ratings[#{k}]=#{v}"
      end
    end
    movies_path + "?sort_by=#{s}" + ratings
  end

  def hidden_sort_by

    if (@order_by != nil)
      s = hidden_field_tag "sort_by", @order_by
    else
      s = ""
    end
    return s
  end

  def hilite(s)
    return s.eql?(@order_by) ? "hilite" : "nohilite"
  end

  def checked(r)
    return false if @ratings == nil
    v = @ratings[r]
    return v != nil
  end
end
