defmodule Prism.Category do
  use Ecto.Schema
  import Ecto.Changeset
  alias Prism.Category

  schema "categories" do
    field :name, :string

    belongs_to :parent, Category

    timestamps()
  end

  def changeset(%Category{} = category, attrs) do
    category
    |> cast(attrs, [:name, :parent_id])
    |> validate_required([:name])
    end
end
