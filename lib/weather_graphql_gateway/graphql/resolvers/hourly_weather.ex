defmodule WeatherGraphqlGateway.Graphql.Resolvers.HourlyWeather do
  @moduledoc """
  This module contains resolver function for fetching hourly weather data in GraphQL queries.
  """
  alias WeatherGraphqlGateway.OpenMeteoApi.GraphqlAdapter

  @doc """
  Fetches hourly weather data based on the provided parameters.

  This resolver function calls the `OpenMeteoApi.GraphqlAdapter.request_hourly_weather/6` function to fetch hourly weather data from the OpenMeteoAPI.
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
  def get_data(parent, %{forecast_days: forecast_days}, _resolution) do
    response = GraphqlAdapter.request_hourly_weather(%{
      forecast_days: forecast_days,
      latitude: parent.latitude,
      longitude: parent.longitude,
      precipitation_unit: parent.precipitation_unit,
      temperature_unit: parent.temperature_unit,
      wind_speed_unit: parent.wind_speed_unit,
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
