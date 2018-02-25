defmodule PrismWeb.Router do
  use PrismWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", PrismWeb do
    pipe_through :api

    get "/events", EventsController, :index
    get "/events/:id", EventsController, :show
    put "/events/:id", EventsController, :update
    post "/events", EventsController, :create
    delete "/events/:id", EventsController, :delete

    get "/categories", CategoriesController, :index
    get "/categories/:id", CategoriesController, :show
    get "/categories/:id/subs", CategoriesController, :show_subs
    put "/categories/:id", CategoriesController, :update
    post "/categories", CategoriesController, :create
    delete "/categories/:id", CategoriesController, :delete

  end
end
