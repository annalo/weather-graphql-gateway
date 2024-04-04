defmodule WeatherGraphqlGateway.OpenMeteoAPI.Models.HourlyWeather do
  @moduledoc """
  Represents hourly weather data returned by the Open Meteo API.

  This module provides a structured representation of hourly weather data returned by the Open Meteo API.

  ## Fields

  - `is_day`: Flag indicating if it's daytime.
  - `precipitation_probability`: The precipitation probability.
  - `temperature_2m`: The temperature at 2 meters above ground level.
  - `time`: The time of the hourly weather data.
  - `weather_code`: The weather code representing the weather condition.
"""
  defstruct [
    :is_day,
    :precipitation_probability,
    :temperature_2m,
    :time,
    :weather_code
  ]

  @type t :: %__MODULE__{
          is_day: [number()],
          precipitation_probability: [number()],
          temperature_2m: [number()],
          time: [String.t()],
          weather_code: [number()]
        }
end
