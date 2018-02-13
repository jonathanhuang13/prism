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

# -- SEED USERS --

user = Repo.insert! %User {
  first_name: "John",
  last_name: "Doe",
  email: "johndoe@gmail.com"
}
