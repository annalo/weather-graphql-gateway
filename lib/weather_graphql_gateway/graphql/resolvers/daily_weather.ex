defmodule WeatherGraphqlGateway.Graphql.Resolvers.DailyWeather do
  @moduledoc """
  This module contains resolver function for fetching daily weather data in GraphQL queries.
  """
  alias WeatherGraphqlGateway.OpenMeteoAPI.GraphqlAdapter

  @doc """
  Fetches daily weather data based on the provided parameters.

  This resolver function calls the `OpenMeteoAPI.GraphqlAdapter.request_daily_weather/6` function to fetch daily weather data from the OpenMeteoAPI.
  """
  @spec get_data(
          atom()
          | %{
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
      GraphqlAdapter.request_daily_weather(%{
        forecast_days: forecast_days,
        latitude: latitude,
        longitude: longitude,
        precipitation_unit: precipitation_unit,
        temperature_unit: temperature_unit,
        wind_speed_unit: wind_speed_unit,
        fields: [
          "precipitation_probability_max",
          "sunrise",
          "sunset",
          "temperature_2m_max",
          "temperature_2m_min",
          "weather_code"
        ]
      })

    {:ok, response}
  end
end
