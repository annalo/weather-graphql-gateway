defmodule WeatherGraphqlGateway.OpenMeteoAPI.Models.CurrentWeather do
  @moduledoc """
  Represents current weather data returned by the Open Meteo API.

  This module provides a structured representation of current weather data returned by the Open Meteo API.

  ## Fields

  - `apparent_temperature`: The apparent temperature.
  - `is_day`: Flag indicating if it's daytime.
  - `precipitation`: The precipitation.
  - `relative_humidity_2m`: The relative humidity at 2 meters above ground level.
  - `temperature_2m`: The temperature at 2 meters above ground level.
  - `weather_code`: The weather code representing the weather condition.
  - `wind_speed_10m`: The wind speed at 10 meters above ground level.

"""
  defstruct [
    :apparent_temperature,
    :is_day,
    :precipitation,
    :relative_humidity_2m,
    :temperature_2m,
    :weather_code,
    :wind_speed_10m
  ]

  @type t :: %__MODULE__{
    apparent_temperature: number(),
    is_day: number(),
    precipitation: number(),
    relative_humidity_2m: number(),
    temperature_2m: number(),
    weather_code: number(),
    wind_speed_10m: number()
  }
end
