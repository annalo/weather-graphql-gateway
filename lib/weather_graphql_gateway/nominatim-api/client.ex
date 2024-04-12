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

  def geocode(query) do
    query
    |> build_geocode_url()
    |> Req.get()
    |> handle_response()
  end

  def reverse_geocode(%{lat: lat, lon: lon}) do
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

  @doc """
  - `response` (term) - The response returned by `Req.get!`.

  Returns:

  - The response body (`%{}`) on successful request.
  - The raised `Exception.t()` on error.

  This function extracts the response body from a successful response or re-raises
  any encountered error. You might want to implement more robust error handling here.
  """
  @spec handle_response({:ok, Req.Response.t()}) :: %{}
  @spec handle_response({:error, Exception.t()}) :: Exception.t()
  def handle_response({:ok, response}), do: response.body
  def handle_response({:error, exception}), do: exception
end
