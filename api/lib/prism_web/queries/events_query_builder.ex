defmodule PrismWeb.EventsQueryBuilder do
  import Ecto.Query
  alias Prism.Events

  def filter_by_location(query, params) do
    params["location"]
      |> case do
          text -> query |> where([e], e.location == ^text)
         end
  end
end
