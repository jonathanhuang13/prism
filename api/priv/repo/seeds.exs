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
alias Api.Event

# -- SEED USERS -- 

user = Repo.insert! %User{
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


# -- SEED EVENTS --
defmodule Api.SeedEvents do
  def seed(row) do
    user = Repo.get_by(User, last_name: "Doe")
    category = Repo.get_by(Category, name: row.activity)
    
    start_time = DateTime.from_iso8601(row.start)
    end_time = DateTime.from_iso8601(row.end)

    event = %Event{start: elem(start_time, 1), end: elem(end_time, 1), location: row.location, description: row.description, user: user, category: category}

    Repo.insert!(event)

  end
end

File.stream!("./priv/repo/events.csv")
  |> Stream.drop(1)
  |> CSV.decode!(headers: [:start, :end, :location, :category, :activity, :qualifier, :description, :measurement, :value])
  |> Enum.each(&Api.SeedEvents.seed/1)
