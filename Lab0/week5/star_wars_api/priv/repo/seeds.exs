# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     StarWarsApi.Repo.insert!(%StarWarsApi.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

StarWarsApi.Repo.insert_all(StarWarsApi.Movies.Movie, [
  %{id: 1, title: "Star Wars: Episode IV - A New Hope", release_year: 1977, director: "George Lucas", inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now, :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now, :second)},
  %{id: 2, title: "Star Wars: Episode V - The Empire Strikes Back", release_year: 1980, director: "Irvin Kershner", inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now, :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now, :second)},
  %{id: 3, title: "Star Wars: Episode VI - Return of the Jedi", release_year: 1983, director: "Richard Marquand", inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now, :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now, :second)},
  %{id: 4, title: "Star Wars: Episode I - The Phantom Menace", release_year: 1999, director: "George Lucas", inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now, :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now, :second)},
  %{id: 5, title: "Star Wars: Episode II - Attack of the Clones", release_year: 2002, director: "George Lucas", inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now, :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now, :second)},
  %{id: 6, title: "Star Wars: Episode III - Revenge of the Sith", release_year: 2005, director: "George Lucas", inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now, :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now, :second)},
  %{id: 7, title: "Star Wars: The Force Awakens", release_year: 2015, director: "J. J. Abrams", inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now, :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now, :second)},
  %{id: 8, title: "Rogue One: A Star Wars Story", release_year: 2016, director: "Gareth Edwards", inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now, :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now, :second)},
  %{id: 9, title: "Star Wars: The Last Jedi", release_year: 2017, director: "Rian Johnson", inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now, :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now, :second)},
  %{id: 10, title: "Solo: A Star Wars Story", release_year: 2018, director: "Ron Howard", inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now, :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now, :second)},
  %{id: 11, title: "Star Wars: The Rise of Skywalker", release_year: 2019, director: "J. J. Abrams", inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now, :second), updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now, :second)}
])
