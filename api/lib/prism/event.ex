defmodule Prism.Event do
  use Ecto.Schema
  import Ecto.Changeset
  alias Prism.Event

  schema "events" do
    field :start, :utc_datetime
    field :end, :utc_datetime
    field :location, :string
    field :description, :string

    timestamps()
  end

  @doc false
  def changeset(%Event{} = event, attrs) do
    user
    |> cast(attrs, [:start, :end, :location, :description])
    |> validate_required([:start, :end, :location, :description])
end
