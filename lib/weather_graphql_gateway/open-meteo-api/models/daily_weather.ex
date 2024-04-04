defmodule WeatherGraphqlGateway.OpenMeteoAPI.Models.DailyWeather do
  @moduledoc """
    Represents daily weather data returned by the Open Meteo API.

    This module provides a structured representation of daily weather data returned by the Open Meteo API.

    ## Fields

    - `precipitation_probability_mean`: The mean precipitation probability (in percentage).
    - `precipitation_sum`: Total daily precipitation amount. (in millimeters)
    - `sunrise`: The time of sunrise. (in local timezone)
    - `sunset`: The time of sunset. (in local timezone)
    - `temperature_2m_max`: The maximum temperature at 2 meters above ground level.
    - `temperature_2m_min`: The minimum temperature at 2 meters above ground level.
    - `weather_code`: The weather code representing the weather condition.
  """

  @derive {Poison.Encoder, only: [
    :precipitation_probability_mean,
    :precipitation_sum,
    :sunrise,
    :sunset,
    :temperature_2m_max,
    :temperature_2m_min,
    :weather_code
  ]}

  defstruct [
    :precipitation_probability_mean,
    :precipitation_sum,
    :sunrise,
    :sunset,
    :temperature_2m_max,
    :temperature_2m_min,
    :weather_code
  ]

  @type t :: %__MODULE__{
          precipitation_probability_mean: number(),
          precipitation_sum: number(),
          sunrise: String.t(),
          sunset: String.t(),
          temperature_2m_max: number(),
          temperature_2m_min: number(),
          weather_code: number()
        }
end
