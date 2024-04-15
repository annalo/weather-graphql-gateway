defmodule WeatherGraphqlGateway.NominatimAPI.Client do
  @moduledoc """
  A module for interacting with the Nominatim Geocoding API.

  This module provides functions to fetch forward and reverse geocoding data from
  the Nominatim API (https://nominatim.openstreetmap.org). It defines a client that
  can be used to make requests to the API and retrieve geocoding information.
  """
  alias WeatherGraphqlGateway.NominatimAPI.Models.Geocode
  require Logger
  # https://nominatim.openstreetmap.org/search?<params>
  @geocode_url "https://nominatim.openstreetmap.org/search?format=jsonv2"
  @reverse_url "https://nominatim.openstreetmap.org/reverse?format=jsonv2"

  # zoom: Level of detail required for the address
  # https://nominatim.org/release-docs/develop/api/Reverse/#example-with-formatjsonv2
  # set to zoom to neighborhood
  @zoom_level 10

  import Plug.Conn.Query

  @doc """
  Performs forward geocoding using the Nominatim Geocoding API.

  This function takes a textual address as input and attempts to convert it into geographical coordinates (lat and lon). It utilizes the Nominatim API to retrieve the corresponding geocoding information.

  ## Arguments:

  - `query`: The address query.
  - `limit`: Limit the maximum number of returned results. Cannot be more than 40. Defaults to 10
  - `language`: Preferred language order for showing search results. This may either be a simple comma-separated list of language codes. Defaults to 'en'.

  ## Returns:

  A map containing the geocoding information retrieved from the Nominatim API, or an exception if the request fails. The returned map may include keys like `lat`, `lon`, and other details depending on the API response.
  """
  @spec geocode(String.t()) :: [map()]
  def geocode(query) do
    query
    |> build_geocode_url()
    |> Req.get()
    |> handle_response()
  end

  @spec geocode(String.t(), %{
          language: String.t() | nil,
          limit: number() | nil
        }) :: [map()]
  def geocode(query, %{language: language, limit: limit}) do
    query
    |> build_geocode_url(limit, language)
    |> Req.get()
    |> handle_response()
  end

  @doc """
  Performs reverse geocoding using the Nominatim Geocoding API.

  This function takes a map containing lat and lon keys as input and attempts to convert those coordinates into a human-readable address. It utilizes the Nominatim API to retrieve the corresponding address details.

  # Arguments

    - `coordinates` - A map with :lat and :lon keys representing the geographical coordinates to be reverse geocoded.
    - `language` - "Preferred language order for showing search results. This may either be a simple comma-separated list of language codes. Defaults to 'en'."

  # Returns

  A map containing the address details retrieved from the Nominatim API based on the provided coordinate.
  """
  @spec reverse_geocode(number(), number()) :: map()
  def reverse_geocode(lat, lon) do
    build_reverse_url(lat, lon)
    |> Req.get()
    |> handle_response()
  end

  @spec reverse_geocode(number(), number(), String.t() | nil) :: map()
  def reverse_geocode(lat, lon, language) do
    build_reverse_url(lat, lon, language)
    |> Req.get()
    |> handle_response()
  end

  @spec build_geocode_url(String.t()) :: String.t()
  defp build_geocode_url(query), do: @geocode_url <> "&" <> encode(q: query)

  @spec build_geocode_url(String.t(), integer() | nil, String.t() | nil) :: String.t()
  defp build_geocode_url(query, limit, language) do
    case {limit, language} do
      {nil, nil} ->
        @geocode_url <> "&" <> encode(q: query)

      {nil, language} ->
        @geocode_url <> "&" <> encode(q: query, "accept-language": language)

      {limit, nil} ->
        @geocode_url <> "&" <> encode(q: query, limit: limit)

      {limit, language} ->
        @geocode_url <> "&" <> encode(q: query, "accept-language": language, limit: limit)
    end
  end

  @spec build_reverse_url(number(), number()) :: String.t()
  defp build_reverse_url(lat, lon) do
    @reverse_url <> "&" <> encode_reverse_url_params(lat, lon, nil)
  end

  @spec build_reverse_url(number(), number(), nil) :: String.t()
  defp build_reverse_url(lat, lon, nil) do
    @reverse_url <> "&" <> encode_reverse_url_params(lat, lon, nil)
  end

  @spec build_reverse_url(number(), number(), String.t()) :: String.t()
  defp build_reverse_url(lat, lon, language) do
    @reverse_url <> "&" <> encode_reverse_url_params(lat, lon, language)
  end

  @spec encode_reverse_url_params(number(), number(), nil) :: String.t()
  defp encode_reverse_url_params(lat, lon, nil) do
    encode(lat: lat, lon: lon, zoom: @zoom_level)
  end

  @spec encode_reverse_url_params(number(), number(), String.t()) :: String.t()
  defp encode_reverse_url_params(lat, lon, language) do
    encode(
      lat: lat,
      lon: lon,
      "accept-language": language,
      zoom: @zoom_level
    )
  end

  @spec handle_response({:ok, Req.Response.t()}) :: %{}
  @spec handle_response({:error, Exception.t()}) :: Exception.t()
  defp handle_response({:ok, response}), do: response.body |> deserialize_response()
  defp handle_response({:error, exception}), do: exception

  @spec deserialize_response([map()]) :: [Geocode.t()]
  defp deserialize_response(list) when is_list(list) do
    for object <- list, do: deserialize_response(object)
  end

  @spec deserialize_response(map()) :: Geocode.t()
  defp deserialize_response(object) do
    # Logger.debug("#{object}")

    %Geocode{
      boundingbox: object["boundingbox"] |> deserialize_boundingbox(),
      display_name: object["display_name"],
      lat: object["lat"] |> String.to_float(),
      lon: object["lon"] |> String.to_float(),
      name: object["name"],
      place_rank: object["place_rank"]
    }
  end

  defp deserialize_boundingbox(list), do: Enum.map(list, &String.to_float/1)
end
