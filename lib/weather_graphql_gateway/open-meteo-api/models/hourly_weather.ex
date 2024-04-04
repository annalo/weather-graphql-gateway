defmodule WeatherGraphqlGateway.OpenMeteoAPI.Models.HourlyWeather do
  @moduledoc """
  Represents hourly weather data returned by the Open Meteo API.

  This module provides a structured representation of hourly weather data returned by the Open Meteo API.

  ## Fields

  - `is_day`: 1 if the current time step has daylight, 0 at night.
  - `precipitation_probability`: The precipitation probability. (in percentage)
  - `temperature_2m`: The air temperature at 2 meters above ground level. (C/F)
  - `time`: The time of the hourly weather data. (YYYY-MM-ddThh:mm i.e. "2024-01-01T00:00")
  - `weather_code`: Weather condition as a numeric code. Follow WMO weather interpretation codes.
"""
  defstruct [
    :is_day,
    :precipitation_probability,
    :temperature_2m,
    :time,
    :weather_code
  ]

  @type t :: %__MODULE__{
          is_day: [integer()],
          precipitation_probability: [integer()],
          temperature_2m: [number()],
          time: [String.t()],
          weather_code: [integer()]
        }
end
