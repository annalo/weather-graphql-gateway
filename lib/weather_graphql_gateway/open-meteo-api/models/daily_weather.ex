defmodule WeatherGraphqlGateway.OpenMeteoAPI.Models.DailyWeather do
  @moduledoc """
    Represents daily weather data returned by the Open Meteo API.

    This module provides a structured representation of daily weather data returned by the Open Meteo API.

    ## Fields

    - `precipitation_probability_max`: The max precipitation probability (in percentage).
    - `sunrise`: The time of sunrise. (in local timezone)
    - `sunset`: The time of sunset. (in local timezone)
    - `temperature_2m_max`: The maximum air temperature at 2 meters above ground level. (C/F)
    - `temperature_2m_min`: The minimum air temperature at 2 meters above ground level. (C/F)
    - `time`: The date of the weather.
    - `weather_code`: Weather condition as a numeric code. Follow WMO weather interpretation codes.
  """
  defstruct [
    :precipitation_probability_max,
    :sunrise,
    :sunset,
    :temperature_2m_max,
    :temperature_2m_min,
    :time,
    :weather_code
  ]

  @type t :: %__MODULE__{
          precipitation_probability_max: [integer()],
          sunrise: [String.t()],
          sunset: [String.t()],
          temperature_2m_max: [number()],
          temperature_2m_min: [number()],
          time: [String.t()],
          weather_code: [integer()]
        }
end
