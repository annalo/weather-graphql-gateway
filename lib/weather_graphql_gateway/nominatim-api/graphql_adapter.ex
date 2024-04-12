defmodule WeatherGraphqlGateway.NominatimAPI.GraphqlAdapter do
  @moduledoc """
  This module serves as an adapter for interfacing with NominatimAPI to fulfill GraphQL requests.

  It provides functions to translate GraphQL queries into requests to the Nominatim and process the responses accordingly.
  """
  alias WeatherGraphqlGateway.NominatimAPI.Client
  import WeatherGraphqlGateway.NominatimAPI.GraphqlSerializer

  def geocode(query) do
    query
    |> Client.geocode()
    |> serialize_geocode_data()
  end

  def reverse_geocode(%{lat: lat, lon: lon}) do
    Client.reverse_geocode(%{lat: lat, lon: lon})
    |> atomize_keys()
  end
end
