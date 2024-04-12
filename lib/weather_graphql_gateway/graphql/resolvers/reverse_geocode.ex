defmodule WeatherGraphqlGateway.Graphql.Resolvers.ReverseGeocode do
  @moduledoc """
    This module contains resolver function for geocoding in GraphQL queries.
  """
  alias WeatherGraphqlGateway.NominatimAPI.GraphqlAdapter

  @doc """
  The `query` resolver returns the parameters to the child resolvers.
  """
  @spec query(
          any(),
          %{:latitude => number(), :longitude => number()},
          any()
        ) :: {:ok, any()}
  def query(_parent, %{latitude: lat, longitude: lon}, _resolution) do
    response = GraphqlAdapter.reverse_geocode(%{lat: lat, lon: lon})
    {:ok, response}
  end
end
