defmodule Api.Event do
  use Ecto.Schema
  import Ecto.Changeset
  alias Api.Event


  schema "events" do
    field :description, :string
    field :end, :utc_datetime
    field :location, :string
    field :start, :utc_datetime

    timestamps()
  end

  @doc false
  def changeset(%Event{} = event, attrs) do
    event
    |> cast(attrs, [:start, :end, :location, :description])
    |> validate_required([:start, :end, :location, :description])
  end
end
