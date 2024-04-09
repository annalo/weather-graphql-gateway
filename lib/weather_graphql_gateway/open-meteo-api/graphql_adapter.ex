defmodule WeatherGraphqlGateway.OpenMeteoApi.GraphqlAdapter do
  require Logger

  @moduledoc """
  This module serves as an adapter for interfacing with the OpenMeteoAPI to fulfill GraphQL requests.

  It provides functions to translate GraphQL queries into requests to the OpenMeteoAPI and process the responses accordingly.
  """
  alias WeatherGraphqlGateway.OpenMeteoAPI.Client
  alias WeatherGraphqlGateway.OpenMeteoAPI.Models.WeatherRequest

  @doc """
  Fetches current weather data for a specific location from the OpenMeteoAPI.

  ## Parameters:

  `latitude`: The latitude of the location.
  `longitude`: The longitude of the location.
  `precipitation_unit`: The unit of measurement for precipitation. Defaults to mm. (mm/inch)
  `temperature_unit`: The unit of measurement for temperature. Defaults to Celsius. (celsius/fahrenheit)
  `wind_speed_unit`: The unit of measurement for wind speed. Defaults to km/h. (kmh, ms, mph, kn)

  ## Returns:

  A map containing the current weather data retrieved from the OpenMeteoAPI.
  """
@spec request_current_weather(%{
  latitude: number(),
  longitude: number(),
  precipitation_unit: String.t(),
  temperature_unit: String.t(),
  wind_speed_unit: String.t()
}) :: nil
def request_current_weather(%{
  latitude: latitude,
  longitude: longitude,
  precipitation_unit: precipitation_unit,
  temperature_unit: temperature_unit,
  wind_speed_unit: wind_speed_unit
}) do
    struct = %WeatherRequest{
      latitude: latitude,
      longitude: longitude,
      temperature_unit: temperature_unit,
      precipitation_unit: precipitation_unit,
      wind_speed_unit: wind_speed_unit,
      current: ["apparent_temperature", "cloud_cover", "is_day", "precipitation", "relative_humidity_2m", "temperature_2m", "weather_code", "wind_speed_10m"]
    }

    Client.get_weather(struct).body["current"] |> atomize()

    # Logger.debug("GRAPHQL ADAPTER WEATHER RESPONSE BODY")
    # Logger.debug("#{weather}")
    # weather
  end

  @doc """
  Fetches daily weather data for a specific location from the OpenMeteoAPI.

  ## Parameters:

  `latitude`: The latitude of the location.
  `longitude`: The longitude of the location.
  `days`: The number of days of forecast data to fetch.
  `temperature_unit`: The unit of measurement for temperature. Defaults to Celsius. (celsius/fahrenheit)
  `precipitation_unit`: The unit of measurement for precipitation. Defaults to mm. (mm/inch)
  `wind_speed_unit`: The unit of measurement for wind speed. Defaults to km/h. (kmh, ms, mph, kn)

  ## Returns:

  A map containing the daily weather data retrieved from the OpenMeteoAPI.
  """
  @spec request_daily_weather(%{
    forecast_days: integer(),
    latitude: number(),
    longitude: number(),
    precipitation_unit: String.t(),
    temperature_unit: String.t(),
    wind_speed_unit: String.t()
  }) :: nil
  def request_daily_weather(%{
    forecast_days: forecast_days,
    latitude: latitude,
    longitude: longitude,
    precipitation_unit: precipitation_unit,
    temperature_unit: temperature_unit,
    wind_speed_unit: wind_speed_unit
  }) do
    struct = %WeatherRequest{
      forecast_days: forecast_days,
      latitude: latitude,
      longitude: longitude,
      precipitation_unit: precipitation_unit,
      temperature_unit: temperature_unit,
      wind_speed_unit: wind_speed_unit,
      daily: ["precipitation_probability_max", "sunrise", "sunset", "temperature_2m_max", "temperature_2m_min", "weather_code"]
    }
    Client.get_weather(struct).body["daily"] |> atomize()
  end

  @doc """
  Fetches hourly weather data for a specific location from the OpenMeteoAPI.

  ## Parameters:

  `latitude`: The latitude of the location.
  `longitude`: The longitude of the location.
  `hours`: The number of hours of forecast data to fetch.
  `precipitation_unit`: The unit of measurement for precipitation. Defaults to mm. (mm/inch)
  `temperature_unit`: The unit of measurement for temperature. Defaults to Celsius. (celsius/fahrenheit)
  `wind_speed_unit`: The unit of measurement for wind speed. Defaults to km/h. (kmh, ms, mph, kn)

  ## Returns:

  A map containing the hourly weather data retrieved from the OpenMeteoAPI.
  """
  @spec request_hourly_weather(%{
    forecast_days: integer(),
    latitude: number(),
    longitude: number(),
    precipitation_unit: String.t(),
    temperature_unit: String.t(),
    wind_speed_unit: String.t()
  }) :: nil
  def request_hourly_weather(%{
    forecast_days: forecast_days,
    latitude: latitude,
    longitude: longitude,
    precipitation_unit: precipitation_unit,
    temperature_unit: temperature_unit,
    wind_speed_unit: wind_speed_unit
  }) do
    struct = %WeatherRequest{
      forecast_days: forecast_days,
      latitude: latitude,
      longitude: longitude,
      precipitation_unit: precipitation_unit,
      temperature_unit: temperature_unit,
      wind_speed_unit: wind_speed_unit,
      hourly: ["is_day", "precipitation_probability", "temperature_2m", "weather_code"]
    }
    Client.get_weather(struct).body["hourly"] |> atomize()
  end

  defp atomize(map) do
    map
    |> Map.new(fn {k, v} -> {String.to_atom(k), v} end)
  end
end
