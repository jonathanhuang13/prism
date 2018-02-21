defmodule Prism.Category do
  use Ecto.Schema
  import Ecto.Changeset
  alias Prism.Category
  alias Prism.Repo

  @derive {Poison.Encoder, except: [:__meta__, :events, :sub_categories]}
  schema "categories" do
    field :name, :string

    belongs_to :parent, Category, foreign_key: :parent_id
    has_many :sub_categories, Category, foreign_key: :parent_id

    has_many :events, Prism.Event

    timestamps()
  end

  def changeset(%Category{} = category, attrs) do
    category
    |> cast(attrs, [:name, :parent_id])
    |> validate_required([:name])
  end

  @doc """
    Recursively loads parents into the given struct until it hits nil
  """
  def load_parents(categories) when is_list(categories) do
    Enum.map(categories, fn(c) -> load_parents(c) end)
  end

  def load_parents(parent) do
    load_parents(parent, 10)
  end

  def load_parents(_, limit) when limit < 0, do: raise "Recursion limit reached"

  def load_parents(%Category{parent: nil} = parent, _), do: parent

  def load_parents(%Category{parent: %Ecto.Association.NotLoaded{}} = parent, limit) do
    parent = parent |> Repo.preload(:parent)
    Map.update!(parent, :parent, &Category.load_parents(&1, limit - 1))
  end

  def load_parents(nil, _), do: nil

  #@doc """
    #Recursively loads children into the given struct until it hits []
  #"""
  #def load_children(model), do: load_children(model, 10)

  #def load_children(_, limit) when limit < 0, do: raise "Recursion limit reached"

  #def load_children(%Category{children: %Ecto.Association.NotLoaded{}} = model, limit) do
    #model = model |> Repo.preload(:children) # maybe include a custom query here to preserve some order
    #Map.update!(model, :children, fn(list) ->
      #Enum.map(list, &Category.load_children(&1, limit - 1))
    #end)
  #end
end
