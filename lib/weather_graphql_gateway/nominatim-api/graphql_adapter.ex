defmodule WeatherGraphqlGateway.NominatimAPI.GraphqlAdapter do
  @moduledoc """
  This module serves as an adapter for interfacing with NominatimAPI to fulfill GraphQL requests.

  It provides functions to translate GraphQL queries into requests to the Nominatim and process the responses accordingly.
  """
  alias WeatherGraphqlGateway.NominatimAPI.Client
  import WeatherGraphqlGateway.NominatimAPI.GraphqlSerializer

  @doc """
  Fetches a list of geocode data for the search query from NominatimAPI.

  ## Parameters:

  `query`: The address query.

  ## Returns:

  A list of location results from the geocode query retrieved from the NominatimAPI.
  """
  def geocode(query) do
    query
    |> Client.geocode()
    |> serialize_geocode_data()
  end

  @doc """
  Retrieves reverse geocode data from NominatimAPI.

  ## Parameters:

  - `location` - A map with :latitude and :longitude keys representing the geographical coordinates to be reverse geocoded.

  ## Returns

  A map containing the address details retrieved from the Nominatim API based on the provided coordinates.
  """
  def reverse_geocode(%{latitude: lat, longitude: lon}) do
    Client.reverse_geocode(%{latitude: lat, longitude: lon})
    |> atomize_keys()
  end
end
