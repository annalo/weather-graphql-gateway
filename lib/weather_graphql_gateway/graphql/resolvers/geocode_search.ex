defmodule WeatherGraphqlGateway.Graphql.Resolvers.GeocodeSearch do
  @moduledoc """
  This module contains resolver function for geocoding in GraphQL queries.
  """
  alias WeatherGraphqlGateway.NominatimAPI.GraphqlAdapter

  @doc """
  The `query` resolver returns the response from the geocode query.
  """
  @spec query(
          %{:language => String.t() | nil},
          %{
            :query => String.t(),
            :limit => integer()
          },
          any()
        ) :: {:ok, any()}
  def query(%{language: language}, %{query: query} = args, _resolution) do
    response =
      GraphqlAdapter.geocode(query, %{
        limit: args[:limit] || nil,
        language: language
      })

    {:ok, response}
  end
end
