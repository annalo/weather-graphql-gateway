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
  - `time`: Time the temperature was taken.
  - `temperature_2m`: The air temperature at 2 meters above ground level. (C/F)
  - `weather_code`: Weather condition as a numeric code. Follow WMO weather interpretation codes.
  - `wind_speed_10m`: The wind speed at 10 meters above ground level. 10 meters is the standard level. (km/h, mph, m/s, knots)

"""
@type t :: %__MODULE__{
        apparent_temperature: number(),
        cloud_cover: integer(),
        is_day: integer(),
        precipitation: integer(),
        relative_humidity_2m: integer(),
        time: String.t(),
        temperature_2m: number(),
        weather_code: integer(),
        wind_speed_10m: number()
      }

  defstruct [
    :apparent_temperature,
    :cloud_cover,
    :is_day,
    :precipitation,
    :relative_humidity_2m,
    :time,
    :temperature_2m,
    :weather_code,
    :wind_speed_10m
  ]
end
