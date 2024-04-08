defmodule WeatherGraphqlGateway.OpenMeteoApi.GraphqlAdapter do
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
  @spec request_current_weather(number(), number(), String.t(), String.t(), String.t()) :: nil
  def request_current_weather(
    latitude,
    longitude,
    precipitation_unit,
    temperature_unit,
    wind_speed_unit
  ) do
    struct = %WeatherRequest{
      latitude: latitude,
      longitude: longitude,
      precipitation_unit: precipitation_unit,
      temperature_unit: temperature_unit,
      wind_speed_unit: wind_speed_unit,
      current: ["apparent_temperature", "cloud_cover", "is_day", "precipitation", "relative_humidity_2m", "time", "temperature_2m", "weather_code", "wind_speed_10m"]
    }
    Client.get_weather(struct)
  end

  @doc """
  Fetches daily weather data for a specific location from the OpenMeteoAPI.

  ## Parameters:

  `latitude`: The latitude of the location.
  `longitude`: The longitude of the location.
  `days`: The number of days of forecast data to fetch.
  `precipitation_unit`: The unit of measurement for precipitation. Defaults to mm. (mm/inch)
  `temperature_unit`: The unit of measurement for temperature. Defaults to Celsius. (celsius/fahrenheit)
  `wind_speed_unit`: The unit of measurement for wind speed. Defaults to km/h. (kmh, ms, mph, kn)

  ## Returns:

  A map containing the daily weather data retrieved from the OpenMeteoAPI.
  """
  @spec request_daily_weather(number(), number(), String.t(), String.t(), String.t(), integer()) :: nil
  def request_daily_weather(
    _latitude,
    _longitude,
    _precipitation_unit,
    _temperature_unit,
    __wind_speed_unit,
    _days
  ) do

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
  @spec request_hourly_weather(number(), number(), String.t(), String.t(), String.t(), integer()) :: nil
  def request_hourly_weather(
    _latitude,
    _longitude,
    _precipitation_unit,
    _temperature_unit,
    __wind_speed_unit,
    _hours
  ) do

  end
end
