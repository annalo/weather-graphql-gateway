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

  - `query`: The address query.
  - `limit`: Limit the maximum number of returned results. Cannot be more than 40. Defaults to 10
  - `language`: Preferred language order for showing search results. This may either be a simple comma-separated list of language codes. Defaults to 'en'.

  ## Returns:

  A list of location results from the geocode query retrieved from the NominatimAPI.
  """
  @spec geocode(
          String.t(),
          %{
            language: String.t() | nil,
            limit: number() | nil
          }
        ) :: [
          Geocode.t()
        ]
  def geocode(
        query,
        %{language: language, limit: limit}
      ) do
    Client.geocode(query, %{language: language, limit: limit})
  end

  @doc """
  Retrieves reverse geocode data from NominatimAPI.

  ## Parameters:

  - `coordinates` - A map with :lat and :lon keys representing the geographical coordinates to be reverse geocoded.

  ## Returns

  A map containing the address details retrieved from the Nominatim API based on the provided coordinates.
  """
  @spec reverse_geocode(number(), number()) :: map()
  def reverse_geocode(lat, lon), do: Client.reverse_geocode(lat, lon)

  @spec reverse_geocode(number(), number(), String.t() | nil) :: map()
  def reverse_geocode(lat, lon, language) do
    Client.reverse_geocode(lat, lon, language)
  end
end
