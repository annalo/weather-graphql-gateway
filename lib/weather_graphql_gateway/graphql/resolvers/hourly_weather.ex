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
              :latitude => number(),
              :longitude => number(),
              :precipitation_unit => binary(),
              :temperature_unit => binary(),
              :wind_speed_unit => binary(),
              optional(any()) => any()
            },
          %{:hours => integer()},
          any()
        ) :: nil
  def get_data(parent, %{hours: hours}, _resolution) do
    GraphqlAdapter.request_hourly_weather(
      parent.latitude,
      parent.longitude,
      parent.precipitation_unit,
      parent.temperature_unit,
      parent.wind_speed_unit,
      hours
    )
  end
end
