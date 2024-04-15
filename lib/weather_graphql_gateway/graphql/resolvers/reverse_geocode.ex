defmodule WeatherGraphqlGateway.Graphql.Resolvers.ReverseGeocode do
  @moduledoc """
    This module contains resolver function for geocoding in GraphQL queries.
  """
  alias WeatherGraphqlGateway.NominatimAPI.GraphqlAdapter

  @doc """
  The `query` resolver returns the parameters to the child resolvers.
  """
  @spec query(
          %{language: String.t()},
          %{:latitude => number(), :longitude => number()},
          any()
        ) :: {:ok, any()}
  def query(
        %{language: language},
        %{latitude: lat, longitude: lon},
        _resolution
      ) do
    response =
      GraphqlAdapter.reverse_geocode(lat, lon, language)

    {:ok, response}
  end
end
