defmodule PrismWeb.EventsController do
  use PrismWeb, :controller
  alias Prism.Repo
  alias Prism.Event
  alias PrismWeb.EventsQueryBuilder

  def index(conn, params) do
    events = Event
      |> EventsQueryBuilder.filter_by_location(params)
      |> EventsQueryBuilder.filter_by_start_time(params)
      |> EventsQueryBuilder.filter_by_end_time(params)
      |> Repo.all
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

  def update(conn, %{"id" => id} = params) do
    event = Repo.get(Event, String.to_integer(id))
      |> Event.load_category
      |> Repo.preload([:user])

    changeset = Event.changeset(event, params)

    resp = Repo.update!(changeset)

    json conn, resp
  end

  def create(conn, params) do
    %{"user_id" => user_id, "category_id" => category_id, "location" => location, "description" => description} = params

    user = Repo.get(Prism.User, user_id)
    category = Repo.get(Prism.Category, category_id)
      |> Prism.Category.load_parents


    {:ok, start_time, _} = DateTime.from_iso8601(params["start"])
    {:ok, end_time, _} = DateTime.from_iso8601(params["end"])

    event = %Event{start: start_time, end: end_time, location: location, description: description, user: user, category: category}

    event = Repo.insert!(event)
    json conn, event
  end

  def delete(conn, %{"id" => id}) do
    event = Repo.get(Event, String.to_integer(id))
      |> Event.load_category
      |> Repo.preload([:user])

    resp = Repo.delete!(event)
    json conn, resp
  end
end
