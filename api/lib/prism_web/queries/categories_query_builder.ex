defmodule PrismWeb.CategoriesQueryBuilder do
  import Ecto.Query
  alias Prism.Category

  def filter_by_main(query, params) do
    params["main"]
      |> case do
          "true" -> query |> where([c], is_nil(c.parent_id))
          _      -> query
         end
  end

end
