defmodule WeatherGraphqlGateway.NominatimAPI.Client do
  @moduledoc """
  A module for interacting with the Nominatim Geocoding API.

  This module provides functions to fetch forward and reverse geocoding data from
  the Nominatim API (https://nominatim.openstreetmap.org). It defines a client that
  can be used to make requests to the API and retrieve geocoding information.
  """

  # https://nominatim.openstreetmap.org/search?<params>
  @geocode_url "https://nominatim.openstreetmap.org/search?format=jsonv2&accept-language=en"
  @reverse_url "https://nominatim.openstreetmap.org/reverse?format=jsonv2&accept-language=en"

  import Plug.Conn.Query

  @doc """
  Performs forward geocoding using the Nominatim Geocoding API.

  This function takes a textual address as input and attempts to convert it into geographical coordinates (latitude and longitude). It utilizes the Nominatim API to retrieve the corresponding geocoding information.

  ## Arguments:

    - `query` (String) - The textual address to be geocoded.

  ## Returns:

  A map containing the geocoding information retrieved from the Nominatim API, or an exception if the request fails. The returned map may include keys like `latitude`, `longitude`, and other details depending on the API response.
  """
  def geocode(query) do
    query
    |> build_geocode_url()
    |> Req.get()
    |> handle_response()
  end

  @doc """
  Performs reverse geocoding using the Nominatim Geocoding API.

  This function takes a map containing latitude and longitude keys as input and attempts to convert those coordinates into a human-readable address. It utilizes the Nominatim API to retrieve the corresponding address details.

  # Arguments

    - `location` - A map with :latitude and :longitude keys representing the geographical coordinates to be reverse geocoded.

  # Returns

  A map containing the address details retrieved from the Nominatim API based on the provided coordinate.
  """
  def reverse_geocode(%{latitude: lat, longitude: lon}) do
    build_reverse_url(lat, lon)
    |> Req.get()
    |> handle_response()
  end

  defp build_geocode_url(query) do
    @geocode_url <> "&" <> encode(q: query)
  end

  defp build_reverse_url(lat, lon) do
    # zoom: Level of detail required for the address
    # https://nominatim.org/release-docs/develop/api/Reverse/#example-with-formatjsonv2
    # set to zoom to neighborhood
    params = encode(lat: lat, lon: lon, zoom: 14)
    @reverse_url <> "&" <> params
  end

  @spec handle_response({:ok, Req.Response.t()}) :: %{}
  @spec handle_response({:error, Exception.t()}) :: Exception.t()
  defp handle_response({:ok, response}), do: response.body
  defp handle_response({:error, exception}), do: exception
end
