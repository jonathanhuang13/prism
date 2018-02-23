defmodule PrismWeb.CategoriesController do
  import Ecto.Query
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
    
    Repo.update!(changeset)
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

  def delete(conn, %{"id" => id}) do
    category = Repo.get(Category, String.to_integer(id))
      |> Category.load_parents

    resp = Repo.delete!(category)
    json(conn, resp)
  end

  def index_main(conn, _params) do
    query = from(c in Category, where: is_nil(c.parent_id))

    categories = Repo.all(query)
      |> Category.load_parents

    json(conn, categories)
  end

  def show_subs_for_main(conn, %{"mainId" => id}) do
    query = from(c in Category, where: c.parent_id == ^String.to_integer(id))

    categories = Repo.all(query)
      |> Category.load_parents

    json(conn, categories)
  end
end
