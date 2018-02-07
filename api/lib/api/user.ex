defmodule Api.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Api.User


  schema "users" do
    field :email, :string
    field :first_name, :string
    field :last_name, :string

    has_many :events, Api.Event

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:first_name, :last_name, :email])
    |> validate_required([:first_name, :last_name, :email])
  end
end
