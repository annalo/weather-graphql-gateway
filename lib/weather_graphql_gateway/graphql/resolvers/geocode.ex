defmodule WeatherGraphqlGateway.Graphql.Resolvers.Geocode do
  @moduledoc """
  This module contains resolver function for geocoding in GraphQL queries.
  """
  alias WeatherGraphqlGateway.NominatimAPI.GraphqlAdapter

  @doc """
  The `query` resolver returns the parameters to the child resolvers.
  """
  @spec query(
          any(),
          %{:query => String.t()},
          any()
        ) :: {:ok, any()}
  def query(_parent, %{query: query}, _resolution) do
    response = GraphqlAdapter.geocode(query)
    {:ok, response}
  end
end
