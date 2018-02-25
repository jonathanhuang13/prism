defmodule PrismWeb.CategoriesController do
  import Ecto.Query
  use PrismWeb, :controller
  alias Prism.Repo
  alias Prism.Category

  def filter_by_main(query, params) do
    params["main"]
      |> case do
          "true" -> query |> where([c], is_nil(c.parent_id))
          _      -> query
         end
  end

  def index(conn, params) do
    categories = Category
      |> filter_by_main(params)
      |> Repo.all
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

  def show_subs(conn, %{"id" => id}) do
    query = from(c in Category, where: c.parent_id == ^String.to_integer(id))

    categories = Repo.all(query)
      |> Category.load_parents

    json(conn, categories)
  end
end
