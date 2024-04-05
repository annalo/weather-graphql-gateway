defmodule WeatherGraphqlGateway.OpenMeteoAPI.Client do
  @moduledoc """
  A module for interacting with the Open Meteo API.
  """

  @base_url "https://api.open-meteo.com/v1/forecast"

  alias Plug.Conn.Query
  alias WeatherGraphqlGateway.OpenMeteoAPI.Models.WeatherRequest

  # @spec get_weather(WeatherRequest.t()) :: {:ok, map()} | {:error, any()}
  def get_weather(%WeatherRequest{} = request) do
    request
    |> build_url()
    |> Req.get()
    |> handle_response()
  end

  @spec build_url(WeatherGraphqlGateway.OpenMeteoAPI.Models.WeatherRequest.t()) :: String.t()
  def build_url(%WeatherRequest{} = request) do
    params = params_without_nil(request)
    @base_url <> "?" <> Query.encode(params)
  end

  @spec handle_response({:ok, Req.Response.t()}) :: %{}
  @spec handle_response({:error, Exception.t()}) :: Exception.t()
  def handle_response({:ok, response}), do: response.body
  def handle_response({:error, exception}), do: exception

  # remove keys with nil value from params
  defp params_without_nil(%WeatherRequest{} = struct) do
    Map.from_struct(struct) |>
    Enum.reduce(%{}, fn {key, value}, acc ->
      if value != nil, do: Map.put(acc, key, value), else: acc
    end)
  end
end
