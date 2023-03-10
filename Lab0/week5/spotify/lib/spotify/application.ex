defmodule Spotify.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      SpotifyWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Spotify.PubSub},
      # Start the Endpoint (http/https)
      SpotifyWeb.Endpoint
      # Start a worker by calling: Spotify.Worker.start_link(arg)
      # {Spotify.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Spotify.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    SpotifyWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
