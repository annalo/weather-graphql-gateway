defmodule WeatherGraphqlGateway.Graphql.Resolvers.GeocodeSearch do
  @moduledoc """
  This module contains resolver function for geocoding in GraphQL queries.
  """
  alias WeatherGraphqlGateway.NominatimAPI.GraphqlAdapter

  @doc """
  The `query` resolver returns the parameters to the child resolvers.
  """
  @spec query(
          any(),
          %{
            :query => String.t(),
            :limit => integer(),
            :language => String.t()
          },
          any()
        ) :: {:ok, any()}
  def query(_parent, %{query: query, limit: limit, language: language}, _resolution) do
    response = GraphqlAdapter.geocode(query, limit, language)
    {:ok, response}
  end
end
