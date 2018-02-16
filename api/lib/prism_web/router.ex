defmodule PrismWeb.Router do
  use PrismWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", PrismWeb do
    pipe_through :api

    get "/events", EventsController, :index
  end
end
