defmodule WeatherGraphqlGateway.Graphql.Resolvers.HourlyWeather do
  @moduledoc """
  This module contains resolver function for fetching hourly weather data in GraphQL queries.
  """
  alias WeatherGraphqlGateway.OpenMeteoAPI.GraphqlAdapter

  @doc """
  Fetches hourly weather data based on the provided parameters.

  This resolver function calls the `OpenMeteoAPI.GraphqlAdapter.request_hourly_weather/6` function to fetch hourly weather data from the OpenMeteoAPI.
  """
  @spec get_data(
          %{
            :forecast_days => integer(),
            :latitude => number(),
            :longitude => number(),
            :precipitation_unit => String.t(),
            :temperature_unit => String.t(),
            :wind_speed_unit => String.t()
          },
          %{:forecast_days => integer()},
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
        %{forecast_days: forecast_days},
        _resolution
      ) do
    response =
      GraphqlAdapter.request_hourly_weather(%{
        forecast_days: forecast_days,
        latitude: latitude,
        longitude: longitude,
        precipitation_unit: precipitation_unit,
        temperature_unit: temperature_unit,
        wind_speed_unit: wind_speed_unit,
        fields: [
          "is_day",
          "precipitation_probability",
          "temperature_2m",
          "weather_code"
        ]
      })

    {:ok, response}
  end
end
