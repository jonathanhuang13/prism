defmodule Prism.Event do
  use Ecto.Schema
  import Ecto.Changeset
  alias Prism.Event
  alias Prism.Repo

  @derive {Poison.Encoder, except: [:__meta__]}
  schema "events" do
    field :start, :utc_datetime
    field :end, :utc_datetime
    field :location, :string
    field :description, :string

    belongs_to :user, Prism.User
    belongs_to :category, Prism.Category
    timestamps()
  end

  @doc false
  def changeset(%Event{} = event, attrs) do
    event
    |> cast(attrs, [:start, :end, :location, :description])
    |> validate_required([:start, :end, :location, :description])
  end

  @doc """
    Recursively loads children into the given struct until it hits []
  """
  def load_category(events) when is_list(events) do
    Enum.map(events, fn(e) -> load_category(e) end)
  end

  def load_category(model), do: load_category(model, 10)

  def load_category(_, limit) when limit < 0, do: raise "Recursion limit reached"

  def load_category(%Event{category: %Ecto.Association.NotLoaded{}} = model, limit) do
    model = model |> Repo.preload(:category) 
    Map.update!(model, :category, &Prism.Category.load_parents(&1, limit - 1))
  end
end
