defmodule WeatherGraphqlGateway.NominatimAPI.GraphqlAdapter do
  @moduledoc """
  This module serves as an adapter for interfacing with NominatimAPI to fulfill GraphQL requests.

  It provides functions to translate GraphQL queries into requests to the Nominatim and process the responses accordingly.
  """
  alias WeatherGraphqlGateway.NominatimAPI.Client
  alias WeatherGraphqlGateway.NominatimAPI.Models.Geocode

  @doc """
  Fetches a list of geocode data for the search query from NominatimAPI.

  ## Parameters:

  `query`: The address query.

  ## Returns:

  A list of location results from the geocode query retrieved from the NominatimAPI.
  """
  @spec geocode(String.t()) :: [Geocode.t()]
  def geocode(query), do: Client.geocode(query)
  @spec geocode(String.t(), number()) :: [Geocode.t()]
  def geocode(query, limit), do: Client.geocode(query, limit)
  @spec geocode(String.t(), number(), String.t()) :: [Geocode.t()]
  def geocode(query, limit, language), do: Client.geocode(query, limit, language)

  @doc """
  Retrieves reverse geocode data from NominatimAPI.

  ## Parameters:

  - `location` - A map with :lat and :lon keys representing the geographical coordinates to be reverse geocoded.

  ## Returns

  A map containing the address details retrieved from the Nominatim API based on the provided coordinates.
  """
  @spec reverse_geocode(%{lat: number(), lon: number()}) :: map()
  def reverse_geocode(%{lat: lat, lon: lon}) do
    Client.reverse_geocode(%{lat: lat, lon: lon})
  end
end
