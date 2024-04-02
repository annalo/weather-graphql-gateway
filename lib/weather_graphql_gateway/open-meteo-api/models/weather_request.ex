defmodule WeatherGraphqlGateway.OpenMeteoAPI.Models.WeatherRequest do
  @moduledoc """
  Represents the query parameters for requesting weather data from the Open Meteo API.
  """

  @type t :: %__MODULE__{
          latitude: number(),
          longitude: number(),
          current: [String.t()],
          hourly: [String.t()],
          daily: [String.t()],
          temperature_unit: String.t(),
          wind_speed_unit: String.t(),
          precipitation_unit: String.t(),
          timezone: String.t(),
          forecast_days: integer(),
          apikey: String.t()
        }

  defstruct [
    :latitude,
    :longitude,
    :current,
    :hourly,
    :daily,
    :temperature_unit,
    :wind_speed_unit,
    :precipitation_unit,
    :timezone,
    :forecast_days,
    :apikey
  ]

  @doc """
  Constructs a new weather request struct.

  ## Parameters

  - `latitude`: The latitude coordinate for the location.
  - `longitude`: The longitude coordinate for the location.
  - `daily`: (optional) A list of weather variables to get daily conditions.
  - `current`: (optional) Whether to include current weather data. Defaults to true.
  - `hourly`: (optional) A list of hourly weather variables which should be returned.
  - `temperature_unit`: (optional) The unit of measurement for temperature. Defaults to Celsius.
  - `wind_speed_unit`: (optional) The unit of measurement for wind speed. Defaults to kmh.
  - `precipitation_unit`: (optional) The unit of measurement for precipitation. Defaults to "mm".
  - `timezone`: (optional) If auto is set, coordinates will be automatically resolved to local time zone.
  - `forecast_days`: (optional) The number of days to include in the forecast. Defaults to 7.
  - `apikey`: (optional) The API key for accessing the Open Meteo API.
  """

  def new(
    latitude,
    longitude,
    current,
    hourly,
    daily,
    temperature_unit,
    wind_speed_unit,
    precipitation_unit,
    timezone,
    forecast_days,
    apikey
  ) do
    %__MODULE__{
      latitude: latitude,
      longitude: longitude,
      current: current,
      hourly: hourly,
      daily: daily,
      temperature_unit: temperature_unit,
      wind_speed_unit: wind_speed_unit,
      precipitation_unit: precipitation_unit,
      timezone: timezone,
      forecast_days: forecast_days,
      apikey: apikey
    }
  end
end
