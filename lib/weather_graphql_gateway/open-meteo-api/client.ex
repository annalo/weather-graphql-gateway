defmodule WeatherGraphqlGateway.OpenMeteoAPI.Client do
  @moduledoc """
  A module for interacting with the Open Meteo API.

  This module provides functions to fetch weather data from the Open Meteo API
  (https://api.open-meteo.com/v1/forecast). It defines a client that can be used to
  make requests to the API and retrieve weather information.
  """

  @base_url "https://api.open-meteo.com/v1/forecast"

  alias Plug.Conn.Query
  alias WeatherGraphqlGateway.OpenMeteoAPI.Models.WeatherRequest

  @doc """
  Fetches weather data from the Open Meteo API based on the provided `WeatherRequest` struct.

  - `request` - A WeatherRequest struct containing the query parameters for the API request.

  Returns:

  - Decoded json object from the HTTP response body on success.
  - An `Exception.t()` on error.

  """
  @spec get_weather(WeatherRequest.t()) :: %{} | Exception.t()
  def get_weather(%WeatherRequest{} = request) do
    request
    |> build_url()
    |> Req.get()
    |> handle_response()
  end

  @doc """
  Constructs the URL for the Open Meteo API request based on the provided `WeatherRequest` struct.

  - `request` - A WeatherRequest struct containing the query parameters for the API request.

  Returns:

  - A `String.t()` containing the complete URL for the API request.

  This function extracts relevant query parameters from the request struct and builds the URL
  incorporating the base URL and encoded query parameters.
  """
  @spec build_url(WeatherGraphqlGateway.OpenMeteoAPI.Models.WeatherRequest.t()) :: String.t()
  def build_url(%WeatherRequest{} = request) do
    params = request |> params() |> Query.encode()
    @base_url <> "?" <> params
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

  @spec params(WeatherRequest.t()) :: %{}
  defp params(%WeatherRequest{} = struct) do
    # remove keys with nil value from params
    Map.from_struct(struct)
    |> Enum.reduce(%{}, fn {key, value}, acc ->
      if value != nil, do: Map.put(acc, key, value), else: acc
    end)
  end
end
