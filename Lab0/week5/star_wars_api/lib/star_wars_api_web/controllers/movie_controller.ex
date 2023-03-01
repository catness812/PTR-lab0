defmodule StarWarsApiWeb.MovieController do
  use StarWarsApiWeb, :controller

  action_fallback StarWarsApiWeb.FallbackController

  # GET /movies
  def index(conn, _params) do
    movies = StarWarsApi.Movies.list_movies()
    render(conn, "index.json", movies: movies)
  end

  # GET /movies/:id
  def show(conn, %{"id" => id}) do
    movie = StarWarsApi.Movies.get_movie!(id)
    render(conn, "show.json", movie: movie)
  end

  # POST /movies
  def create(conn, movie_params) do
    movie = StarWarsApi.Movies.create_movie(movie_params)
    render(conn, "show.json", movie: movie)
  end

  # PUT /movies/:id
  def update(conn, movie_params) do
    id = Map.get(movie_params, "id")
    movie = StarWarsApi.Repo.get!(StarWarsApi.Movies.Movie, id)
    updated_movie = StarWarsApi.Movies.update_movie(movie, movie_params)
    render(conn, "show.json", movie: updated_movie)
  end

  # PATCH /movies/:id
  def patch(conn, movie_params) do
    id = Map.get(movie_params, "id")
    movie = StarWarsApi.Repo.get!(StarWarsApi.Movies.Movie, id)
    updated_movie = StarWarsApi.Movies.update_movie(movie, movie_params)
    render(conn, "show.json", movie: updated_movie)
  end

  # DELETE /movies/:id
  def delete(conn, %{"id" => id}) do
    movie = StarWarsApi.Movies.get_movie!(id)
    StarWarsApi.Movies.delete_movie(movie)
    send_resp(conn, :no_content, "")
  end
end
