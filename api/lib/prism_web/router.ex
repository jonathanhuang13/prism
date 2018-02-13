defmodule PrismWeb.Router do
  use PrismWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", PrismWeb do
    pipe_through :api
  end
end
