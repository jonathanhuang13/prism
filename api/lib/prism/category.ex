defmodule Prism.Category do
  use Ecto.Schema
  import Ecto.Changeset
  alias Prism.Category

  @derive {Poison.Encoder, except: [:__meta__, :events, :sub_categories]}
  schema "categories" do
    field :name, :string

    belongs_to :parent, Category
    has_many :sub_categories, Category, foreign_key: :parent_id

    has_many :events, Prism.Event

    timestamps()
  end

  def changeset(%Category{} = category, attrs) do
    category
    |> cast(attrs, [:name, :parent_id])
    |> validate_required([:name])
  end
end
