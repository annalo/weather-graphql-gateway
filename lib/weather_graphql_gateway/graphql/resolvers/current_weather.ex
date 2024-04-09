defmodule WeatherGraphqlGateway.Graphql.Resolvers.CurrentWeather do
  require Logger

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
    response = GraphqlAdapter.request_current_weather(%{
      latitude: parent.latitude,
      longitude: parent.longitude,
      temperature_unit: parent.temperature_unit,
      precipitation_unit: parent.precipitation_unit,
      wind_speed_unit: parent.wind_speed_unit
    })

    faked = %{
      apparent_temperature: 63.5,
      cloud_cover: 100,
      interval: 900,
      is_day: 1,
      precipitation: 0.0,
      relative_humidity_2m: 83,
      temperature_2m: 64.3,
      time: "2024-04-09T15:00",
      weather_code: 3,
      wind_speed_10m: 9.2
    }

    faked2 = %{
      "apparent_temperature" => 64.4,
      "cloud_cover" => 100,
      "interval" => 900,
      "is_day" => 1,
      "precipitation" => 0.0,
      "relative_humidity_2m" => 81,
      "temperature_2m" => 65.3,
      "time" => "2024-04-09T15:15",
      "weather_code" => 3,
      "wind_speed_10m" => 9.6
    }

    # Logger.debug("CURRENT WEATHER RESOLVER")
    # Logger.debug("#{response}")

    {:ok, response}
  end
end
