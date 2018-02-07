# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Api.Repo.insert!(%Api.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
#

alias Api.Category
alias Api.Repo
alias Api.User

# -- SEED USERS -- 

Repo.insert! %User{
  email: "johndoe@gmail.com",
  first_name: "John",
  last_name: "Doe"
}

# -- SEED CATEGORIES --

defmodule Api.SeedCategories do
  
  def seed_main_categories(row) do
    changeset = Category.changeset(%Category{}, row)
    Repo.insert!(changeset)
  end

  def seed_sub_categories(row) do
    IO.inspect(row)
    parent_id = Repo.get_by(Category, name: row.category).id

    data = %{:name => row.name, :parent_id => parent_id}
    changeset = Category.changeset(%Category{}, data)

    Repo.insert!(changeset)
  end
end

File.stream!("./priv/repo/categories.csv")
  |> Stream.drop(1)
  |> CSV.decode!(headers: [:category, :name])
  |> Enum.filter(fn(row) ->
      row.category == ""
    end
  )
  |> Enum.each(&Api.SeedCategories.seed_main_categories/1)

File.stream!("./priv/repo/categories.csv")
  |> Stream.drop(1)
  |> CSV.decode!(headers: [:category, :name])
  |> Enum.filter(fn(row) ->
      row.category != ""
    end
  )
  |> Enum.each (&Api.SeedCategories.seed_sub_categories/1)
