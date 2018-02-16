defmodule PrismWeb.EventsController do
  use PrismWeb, :controller
  alias Prism.Repo

  def index(conn, _params) do
    events = Repo.get(Prism.Event, 1)
      |> Repo.preload([:user, :category])
    
    IO.inspect(events)
    json conn, events
  end
end
