defmodule PrismWeb.StatsController do
  use PrismWeb, :controller
  alias Prism.Repo
  alias Prism.Event
  alias PrismWeb.EventsQueryBuilder

  def index(conn, params) do
    events = Event
      |> EventsQueryBuilder.filter_by_location(params)
      |> EventsQueryBuilder.filter_by_start_time(params)
      |> EventsQueryBuilder.filter_by_end_time(params)
      |> EventsQueryBuilder.filter_by_category(params)
      |> Repo.all
      |> Event.load_category
      |> Repo.preload([:user])

    total_time = Enum.reduce(events, 0, fn(e, acc) ->
        time = DateTime.diff(e.end, e.start)
        acc + time 
      end)

    num_events = Enum.count(events)

    stats = %{:total_time => total_time, :num_events => num_events}
    
    json conn, stats 
  end

end
