# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Prism.Repo.insert!(%Prism.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Prism.Repo
alias Prism.User
alias Prism.Category
alias Prism.Event

# -- SEED USERS --

user = Repo.insert! %User {
  first_name: "John",
  last_name: "Doe",
  email: "johndoe@gmail.com"
}


# -- SEED CATEGORIES --

defmodule Prism.SeedCategories do
  def seed_main_categories(row) do
    changeset = Category.changeset(%Category{}, row)
    Repo.insert!(changeset)
  end

  def seed_sub_categories(row) do
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
  |> Enum.each(&Prism.SeedCategories.seed_main_categories/1)

File.stream!("./priv/repo/categories.csv")
  |> Stream.drop(1)
  |> CSV.decode!(headers: [:category, :name])
  |> Enum.filter(fn(row) ->
      row.category != ""
    end
  )
  |> Enum.each(&Prism.SeedCategories.seed_sub_categories/1)


# -- SEED EVENTS --

defmodule Prism.SeedEvents do
  def seed(row) do
    user = Repo.get_by(User, last_name: "Doe")
    category = Repo.get_by(Category, name: row.activity)

    {:ok, start_time, _} = DateTime.from_iso8601(row.start)
    {:ok, end_time, _} = DateTime.from_iso8601(row.end)

    event = %Event{start: start_time, end: end_time, location: row.location, description: row.description, user: user, category: category}

    Repo.insert!(event)
  end
end

File.stream!("./priv/repo/events.csv")
  |> Stream.drop(1)
  |> CSV.decode!(headers: [:start, :end, :location, :category, :activity, :qualifier, :description, :measurement, :value])
  |> Enum.each(&Prism.SeedEvents.seed/1)
