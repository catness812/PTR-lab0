defmodule StarWarsApi.Movies do
  @moduledoc """
  The Movies context.
  """

  import Ecto.Query, warn: false

  def list_movies do
    StarWarsApi.Repo.all(
    from i in StarWarsApi.Movies.Movie,
    order_by: i.id)
  end

  def get_movie!(id) do
    StarWarsApi.Repo.get!(StarWarsApi.Movies.Movie, id)
  end

  def create_movie(attrs \\ %{}) do
    %StarWarsApi.Movies.Movie{}
    |> StarWarsApi.Movies.Movie.changeset(attrs)
    |> StarWarsApi.Repo.insert!()
  end

  def update_movie(%StarWarsApi.Movies.Movie{} = movie, attrs) do
    movie
    |> StarWarsApi.Movies.Movie.changeset(attrs)
    |> StarWarsApi.Repo.update!()
  end

  def delete_movie(%StarWarsApi.Movies.Movie{} = movie) do
    StarWarsApi.Repo.delete(movie)
  end

end
