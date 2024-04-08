defmodule WeatherGraphqlGateway.Graphql.Resolvers.DailyWeather do
  @moduledoc """
  This module contains resolver function for fetching daily weather data in GraphQL queries.
  """
  alias WeatherGraphqlGateway.OpenMeteoApi.GraphqlAdapter

  @doc """
  Fetches daily weather data based on the provided parameters.

  This resolver function calls the `OpenMeteoApi.GraphqlAdapter.request_daily_weather/6` function to fetch daily weather data from the OpenMeteoAPI.
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
          %{:forecast_days => integer()},
          any()
        ) :: nil
  def get_data(parent, %{forecast_days: forecast_days}, _resolution) do
    GraphqlAdapter.request_daily_weather(
      parent.latitude,
      parent.longitude,
      parent.precipitation_unit,
      parent.temperature_unit,
      parent.wind_speed_unit,
      forecast_days || 7
    )
  end
end
