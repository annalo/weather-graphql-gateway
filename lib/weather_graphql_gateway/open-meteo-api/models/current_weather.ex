defmodule WeatherGraphqlGateway.OpenMeteoAPI.Models.CurrentWeather do
  @moduledoc """
  Represents current weather data returned by the Open Meteo API.

  This module provides a structured representation of current weather data returned by the Open Meteo API.

  ## Fields

  - `apparent_temperature`: Perceived feels-like temperature combining wind chill factor, relative humidity and solar radiation. (C/F)
  - `cloud_cover`: Total cloud cover as an area fraction. (in percentage)
  - `is_day`: 1 if the current time step has daylight, 0 at night.
  - `precipitation`: Total current precipitation (rain, showers, snow) sum. (mm/inch)
  - `relative_humidity_2m`: The relative humidity at 2 meters above ground level. (in percentage)
  - `temperature_2m`: The air temperature at 2 meters above ground level. (C/F)
  - `weather_code`: Weather condition as a numeric code. Follow WMO weather interpretation codes.
  - `wind_speed_10m`: The wind speed at 10 meters above ground level. 10 meters is the standard level. (km/h, mph, m/s, knots)

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
