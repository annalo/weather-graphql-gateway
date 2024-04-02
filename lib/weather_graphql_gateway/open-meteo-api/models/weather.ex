defmodule WeatherGraphqlGateway.OpenMeteoAPI.Models.Weather do
  @moduledoc """
  Represents weather data returned by the Open Meteo API.

  This module provides a structured representation of the weather data returned by the Open Meteo API, including current, hourly, and daily forecast information.

  ## Fields

  - `utcOffsetSeconds`: The offset in seconds from UTC (Coordinated Universal Time).
  - `timezone`: The timezone for the location.
  - `timezoneAbbreviation`: The timezone abbreviation.
  - `latitude`: The latitude coordinate for the location.
  - `longitude`: The longitude coordinate for the location.
  - `current`: A map containing current weather data.
  - `hourly`: A map containing hourly forecast data.
  - `daily`: A map containing daily forecast data.
  """

  @derive {Poison.Encoder, only: [
    :utcOffsetSeconds,
    :timezone,
    :timezoneAbbreviation,
    :latitude,
    :longitude,
    :current,
    :hourly,
    :daily,
  ]}

  defstruct [
    :utcOffsetSeconds,
    :timezone,
    :timezoneAbbreviation,
    :latitude,
    :longitude,
    :current,
    :hourly,
    :daily,
  ]

  @type t :: %__MODULE__{
          utcOffsetSeconds: integer(),
          timezone: String.t(),
          timezoneAbbreviation: String.t(),
          latitude: number(),
          longitude: number(),
          current: CurrentWeather.t(),
          hourly: HourlyWeather.t(),
          daily: DailyWeather.t(),
        }
end
