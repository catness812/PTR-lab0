defmodule StarWarsApi.Movies.Movie do
  use Ecto.Schema
  import Ecto.Changeset

  schema "movies" do
    field :director, :string
    field :release_year, :integer
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(movie, attrs) do
    movie
    |> cast(attrs, [:title, :release_year, :director])
    |> validate_required([:title, :release_year, :director])
  end
end
