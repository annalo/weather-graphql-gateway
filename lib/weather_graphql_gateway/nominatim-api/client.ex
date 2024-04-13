defmodule WeatherGraphqlGateway.NominatimAPI.Client do
  @moduledoc """
  A module for interacting with the Nominatim Geocoding API.

  This module provides functions to fetch forward and reverse geocoding data from
  the Nominatim API (https://nominatim.openstreetmap.org). It defines a client that
  can be used to make requests to the API and retrieve geocoding information.
  """
  alias WeatherGraphqlGateway.NominatimAPI.Models.Geocode

  # https://nominatim.openstreetmap.org/search?<params>
  @geocode_url "https://nominatim.openstreetmap.org/search?format=jsonv2&accept-language=en"
  @reverse_url "https://nominatim.openstreetmap.org/reverse?format=jsonv2&accept-language=en"

  import Plug.Conn.Query

  @doc """
  Performs forward geocoding using the Nominatim Geocoding API.

  This function takes a textual address as input and attempts to convert it into geographical coordinates (lat and lon). It utilizes the Nominatim API to retrieve the corresponding geocoding information.

  ## Arguments:

    - `query` (String) - The textual address to be geocoded.

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

  @doc """
  Performs reverse geocoding using the Nominatim Geocoding API.

  This function takes a map containing lat and lon keys as input and attempts to convert those coordinates into a human-readable address. It utilizes the Nominatim API to retrieve the corresponding address details.

  # Arguments

    - `location` - A map with :lat and :lon keys representing the geographical coordinates to be reverse geocoded.

  # Returns

  A map containing the address details retrieved from the Nominatim API based on the provided coordinate.
  """
  @spec reverse_geocode(%{lat: number(), lon: number()}) :: map()
  def reverse_geocode(%{lat: lat, lon: lon}) do
    build_reverse_url(lat, lon)
    |> Req.get()
    |> handle_response()
  end

  @spec build_geocode_url(String.t()) :: String.t()
  defp build_geocode_url(query) do
    @geocode_url <> "&" <> encode(q: query)
  end

  @spec build_reverse_url(number(), number()) :: String.t()
  defp build_reverse_url(lat, lon) do
    # zoom: Level of detail required for the address
    # https://nominatim.org/release-docs/develop/api/Reverse/#example-with-formatjsonv2
    # set to zoom to neighborhood
    params = encode(lat: lat, lon: lon, zoom: 10)
    @reverse_url <> "&" <> params
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
    %Geocode{
      address: (object["address"] || %{}) |> serialize_address(),
      boundingbox: object["boundingbox"] |> deserialize_boundingbox(),
      display_name: object["display_name"],
      lat: object["lat"] |> String.to_float(),
      lon: object["lon"] |> String.to_float(),
      name: object["name"],
      place_rank: object["place_rank"]
    }
  end

  defp serialize_address(address) when is_map(address) do
    %{
      city: address["city"],
      country: address["country"],
      country_code: address["country_code"],
      suburb: address["suburb"]
    }
  end

  defp serialize_address(address) when is_nil(address), do: nil

  defp deserialize_boundingbox(list), do: Enum.map(list, &String.to_float/1)
end
