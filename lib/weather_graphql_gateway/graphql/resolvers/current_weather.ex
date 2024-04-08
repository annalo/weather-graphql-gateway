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
  def get_data(parent, _args, _resolution) do
    GraphqlAdapter.request_current_weather(
      parent.latitude,
      parent.longitude,
      parent.precipitation_unit,
      parent.temperature_unit,
      parent.wind_speed_unit
    )
  end
end
