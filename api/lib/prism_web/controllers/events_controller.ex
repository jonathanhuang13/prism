defmodule PrismWeb.EventsController do
  use PrismWeb, :controller
  alias Prism.Repo
  alias Prism.Event

  def index(conn, _params) do
    events = Repo.all(Event)
      |> Event.load_category
      |> Repo.preload([:user])
    
    json conn, events
  end

  def show(conn, %{"id" => id}) do
    event = Repo.get(Event, String.to_integer(id))
      |> Event.load_category
      |> Repo.preload([:user])

    json conn, event
  end
end
