class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  private
  def use_session(name)
    redirect = false
    p = params[name]
    if (p == nil)
      s = session[name]
      if (s != nil)
        params[name] = s
        redirect = true
      end
    else
      session[name] = p
    end
    return redirect
  end

  private
  def redirect_if_needed
    ratings = use_session(:ratings)
    sort_by = use_session(:sort_by)
    if (ratings || sort_by)
      puts params.to_query
      redirect_to movies_path + "?" + params.to_query
    end
  end

  public
  def index
    redirect_if_needed
    @order_by = params[:sort_by]
    all_movies = Movie.order(@order_by)
    @ratings = params[:ratings]
    @movies = []
    if (@ratings != nil)
      all_movies.each do |m|
        @ratings.each do |k, v|
          next if not v.eql?("1")
          if (m.rating.eql?(k))
            @movies.push(m)
          end
        end
      end
    else
      @movies = all_movies
    end
    @all_ratings = []
    all_movies.each do |m|
      @all_ratings.push(m.rating) unless @all_ratings.include?(m.rating)
    end
    @all_ratings.sort!()
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
