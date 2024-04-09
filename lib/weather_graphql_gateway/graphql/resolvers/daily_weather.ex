defmodule WeatherGraphqlGateway.Graphql.Resolvers.DailyWeather do
  @moduledoc """
  This module contains resolver function for fetching daily weather data in GraphQL queries.
  """
  # alias WeatherGraphqlGateway.OpenMeteoApi.GraphqlAdapter

  @doc """
  Fetches daily weather data based on the provided parameters.

  This resolver function calls the `OpenMeteoApi.GraphqlAdapter.request_daily_weather/6` function to fetch daily weather data from the OpenMeteoAPI.
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
  def get_data(parent, args, _resolution) do
    _response = GraphqlAdapter.request_daily_weather(%{
      forecast_days: args.forecast_days,
      latitude: parent.latitude,
      longitude: parent.longitude,
      precipitation_unit: parent.precipitation_unit,
      temperature_unit: parent.temperature_unit,
      wind_speed_unit: parent.wind_speed_unit,
      fields: ["precipitation_probability_max", "sunrise", "sunset", "temperature_2m_max", "temperature_2m_min", "weather_code"]
    })
    {:ok, []}
  end
end
