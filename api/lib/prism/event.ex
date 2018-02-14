defmodule Prism.Event do
  use Ecto.Schema
  import Ecto.Changeset
  alias Prism.Event

  schema "events" do
    field :start, :utc_datetime
    field :end, :utc_datetime
    field :location, :string
    field :description, :string

    belongs_to :user, Prism.User
    timestamps()
  end

  @doc false
  def changeset(%Event{} = event, attrs) do
    event
    |> cast(attrs, [:start, :end, :location, :description])
    |> validate_required([:start, :end, :location, :description])
  end
end
