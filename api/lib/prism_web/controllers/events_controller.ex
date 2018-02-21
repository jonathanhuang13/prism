defmodule PrismWeb.EventsController do
  use PrismWeb, :controller
  alias Prism.Repo

  def index(conn, _params) do
    events = Repo.all(Prism.Event)
      |> Prism.Event.load_category
      |> Repo.preload([:user])
    
    json conn, events
  end
end
