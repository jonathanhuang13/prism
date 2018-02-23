defmodule PrismWeb.CategoriesController do
  use PrismWeb, :controller
  alias Prism.Repo
  alias Prism.Category

  def index(conn, _params) do
    categories = Repo.all(Category)
      |> Category.load_parents

    json(conn, categories)
  end

  def show(conn, %{"id" => id}) do
    category = Repo.get(Category, String.to_integer(id))
      |> Category.load_parents

    json(conn, category)
  end

  def update(conn, %{"id" => id} = params) do
    category = Repo.get(Category, String.to_integer(id))
      |> Category.load_parents

    changeset = Category.changeset(category, params)
    
    resp = Repo.update!(changeset)
    category = Repo.get(Category, String.to_integer(id))
      |> Category.load_parents

    json(conn, category)
  end

  def create(conn, params) do
    changeset = Category.changeset(%Category{}, params)

    category = Repo.insert!(changeset)
      |> Category.load_parents

    json(conn, category)
  end
end
