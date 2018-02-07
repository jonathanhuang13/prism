defmodule Api.Category do
  use Ecto.Schema
  import Ecto.Changeset
  alias Api.Category


  schema "categories" do
    field :name, :string

    has_many :events, Api.Event
    belongs_to :parent, Category
    timestamps()
  end

  @doc false
  def changeset(%Category{} = category, attrs) do
    category
    |> cast(attrs, [:name, :parent_id])
    |> validate_required([:name])
  end
end
