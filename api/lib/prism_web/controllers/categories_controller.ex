defmodule PrismWeb.CategoriesController do
  use PrismWeb, :controller
  alias Prism.Repo
  alias Prism.Category

  def index(conn, _params) do
    categories = Repo.all(Category)
      |> Category.load_parents

    json(conn, categories)
  end
end
