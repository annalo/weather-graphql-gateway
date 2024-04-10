defmodule WeatherGraphqlGateway.Graphql.Resolvers.CurrentWeather do
  @moduledoc """
  This module contains resolver function for fetching current weather data in GraphQL queries.
  """
  alias WeatherGraphqlGateway.OpenMeteoApi.GraphqlAdapter

  @doc """
  Fetches current weather data based on the provided parameters.

  This resolver function calls the `OpenMeteoApi.GraphqlAdapter.request_current_weather/5` function to fetch current weather data from the OpenMeteoAPI.
  """
  @spec get_data(
          atom()
          | %{
              :latitude => number(),
              :longitude => number(),
              :precipitation_unit => String.t(),
              :temperature_unit => String.t(),
              :wind_speed_unit => String.t()
            },
          any(),
          any()
        ) :: nil
  def get_data(
        %{
          latitude: latitude,
          longitude: longitude,
          temperature_unit: temperature_unit,
          precipitation_unit: precipitation_unit,
          wind_speed_unit: wind_speed_unit
        },
        _args,
        _resolution
      ) do
    response =
      GraphqlAdapter.request_current_weather(%{
        latitude: latitude,
        longitude: longitude,
        temperature_unit: temperature_unit,
        precipitation_unit: precipitation_unit,
        wind_speed_unit: wind_speed_unit,
        fields: [
          "apparent_temperature",
          "cloud_cover",
          "is_day",
          "precipitation",
          "relative_humidity_2m",
          "temperature_2m",
          "weather_code",
          "wind_speed_10m"
        ]
      })

    {:ok, response}
  end
end
