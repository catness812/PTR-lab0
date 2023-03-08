# https://accounts.spotify.com/authorize?client_id=$CLIENT_ID&response_type=code&redirect_uri=http://localhost:4000/callback&scope=$SCOPE => CODE
# curl -d client_id=$CLIENT_ID -d client_secret=$CLIENT_SECRET -d grant_type=authorization_code -d code=$CODE -d redirect_uri=$REDIRECT_URI https://accounts.spotify.com/api/token => access.json
# curl -X GET "https://api.spotify.com/v1/me" -H "Authorization: Bearer {access_token}" => user.json

defmodule Spotify do
  def start_link do
    client_id = System.get_env("CLIENT_ID")
    client_secret = System.get_env("CLIENT_SECRET")
    refresh_token = System.get_env("REFRESH_TOKEN")
    scope = System.get_env("SCOPE")
    user_id = System.get_env("USER_ID")

    response = HTTPoison.post(
      "https://accounts.spotify.com/api/token",
      "grant_type=refresh_token&refresh_token=#{refresh_token}&client_id=#{client_id}&client_secret=#{client_secret}&scope=#{scope}",
      [{"Content-Type", "application/x-www-form-urlencoded"}])

    case response do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, %{"access_token" => access_token}} = Jason.decode(body)
        pid = spawn_link(__MODULE__, :loop, [access_token, user_id, nil])
        pid
      _ ->
        {:error, "Error"}
    end
  end

  def loop(access_token, user_id, _playlist_id) do
    receive do
      {:create_public, pid, name, desc} ->
        response = HTTPoison.post(
          "https://api.spotify.com/v1/users/#{user_id}/playlists",
          Jason.encode!(%{name: name, description: desc, public: true}),
          [{"Content-Type", "application/json"}, {"Authorization", "Bearer #{access_token}"}])
        case response do
          {:ok, %HTTPoison.Response{status_code: 201, body: body}} ->
            {:ok, %{"uri" => uri}} = Jason.decode(body)
            [_, _, playlist_id] = String.split(uri, ":")
            send(pid, {:created, playlist_id})
            loop(access_token, user_id, playlist_id)
          _ ->
            {:error, "Error"}
        end

        {:create_private, pid, name, desc} ->
          response = HTTPoison.post(
            "https://api.spotify.com/v1/users/#{user_id}/playlists",
            Jason.encode!(%{name: name, description: desc, public: false}),
            [{"Content-Type", "application/json"}, {"Authorization", "Bearer #{access_token}"}])
          case response do
            {:ok, %HTTPoison.Response{status_code: 201, body: body}} ->
              {:ok, %{"uri" => uri}} = Jason.decode(body)
              [_, _, playlist_id] = String.split(uri, ":")
              send(pid, {:created, playlist_id})
              loop(access_token, user_id, playlist_id)
            _ ->
              {:error, "Error"}
          end

      {:add_song, pid, song_id, playlist_id} ->
        _response = HTTPoison.post(
          "https://api.spotify.com/v1/playlists/#{playlist_id}/tracks?uris=spotify:track:#{song_id}",
          "", [{"Authorization", "Bearer #{access_token}"}])
        send(pid, {:created})
        loop(access_token, user_id, playlist_id)

      {:update_cover, pid, img_str, playlist_id} ->
        _response = HTTPoison.put(
          "https://api.spotify.com/v1/playlists/#{playlist_id}/images",
          img_str, [{"Authorization", "Bearer #{access_token}"}])
        send(pid, {:ok})
        loop(access_token, user_id, playlist_id)
    end
  end

  def create_public(pid, name, desc) do
    send(pid, {:create_public, self(), name, desc})

    receive do
      {:created, playlist_id} ->
        IO.puts("-> playlist `#{name}` has been created")
        playlist_id
      _ ->
        {:error, "Error"}
    end
  end

  def create_private(pid, name, desc) do
    send(pid, {:create_private, self(), name, desc})

    receive do
      {:created, playlist_id} ->
        IO.puts("-> playlist `#{name}` has been created")
        playlist_id
      _ ->
        {:error, "Error"}
    end
  end

  def add_song(pid, song_id, playlist_id) do
    send(pid, {:add_song, self(), song_id, playlist_id})

    receive do
      {:created} ->
        IO.puts("-> song added to playlist")
      _ ->
        {:error, "Error"}
    end
  end

  def update_cover(pid, img_src, playlist_id) do
    case File.read(img_src) do
      {:ok, img} ->
        send(pid, {:update_cover, self(), Base.encode64(img), playlist_id})
      _ ->
        {:error, "Error"}
    end

    receive do
      {:ok} ->
        IO.puts("-> playlist cover updated")
      _ ->
        {:error, "Error"}
    end
  end
end
