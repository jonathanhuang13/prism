defmodule PrismWeb.EventsQueryBuilder do
  import Ecto.Query
  alias Prism.Event

  def filter_by_category(query, params) do
    params["category_id"]
      |> case do
          nil -> query
          id -> query |> where([e], e.category_id == ^String.to_integer(id))
         end 
  end

  def filter_by_location(query, params) do
    params["location"]
      |> case do
          nil -> query
          text -> query |> where([e], e.location == ^text)
         end
  end

  def filter_by_start_time(query, params) do
    if is_nil(params["start_time"]) do
        query
    else
        {:ok, start_time, _} = DateTime.from_iso8601(params["start_time"])

        query
          |> where([e], e.start > ^start_time)
    end
  end

  def filter_by_end_time(query, params) do
    if is_nil(params["end_time"]) do
        query
    else
        {:ok, end_time, _} = DateTime.from_iso8601(params["end_time"])

        query
          |> where([e], e.end < ^end_time)
    end
  end
end
