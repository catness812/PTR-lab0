defmodule StarWarsApiWeb.Router do
  use StarWarsApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", StarWarsApiWeb do
    pipe_through :api
    get "/movies", MovieController, :index
    get "/movies/:id", MovieController, :show
    post "/movies", MovieController, :create
    put "/movies/:id", MovieController, :update
    patch "/movies/:id", MovieController, :update
    delete "/movies/:id", MovieController, :delete
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: StarWarsApiWeb.Telemetry
    end
  end
end
