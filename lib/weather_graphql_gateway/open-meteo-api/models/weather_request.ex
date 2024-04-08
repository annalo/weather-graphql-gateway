defmodule WeatherGraphqlGateway.OpenMeteoAPI.Models.WeatherRequest do
  @moduledoc """
  Represents the query parameters for requesting weather data from the Open Meteo API.

  ## Parameters

  - `latitude`: The latitude coordinate for the location.
  - `longitude`: The longitude coordinate for the location.
  - `current`: (optional) Whether to include current weather data. Defaults to true.
  - `daily`: (optional) A list of weather variables to get daily conditions.
  - `forecast_days`: (optional) The number of days to include in the forecast. Defaults to 7.
  - `hourly`: (optional) A list of hourly weather variables which should be returned.
  - `precipitation_unit`: (optional) The unit of measurement for precipitation. Defaults to mm. (mm/inch)
  - `temperature_unit`: (optional) The unit of measurement for temperature. Defaults to Celsius. (celsius/fahrenheit)
  - `wind_speed_unit`: (optional) The unit of measurement for wind speed. Defaults to kmh. (kmh, ms, mph, kn)
  - `timezone`: (optional) By default set to "auto", coordinates will be automatically resolved to local time zone.
  """
  @enforce_keys [:latitude, :longitude]
  @type t :: %__MODULE__{
          current: [String.t()],
          daily: [String.t()],
          forecast_days: integer(),
          hourly: [String.t()],
          latitude: number(),
          longitude: number(),
          precipitation_unit: String.t(),
          temperature_unit: String.t(),
          wind_speed_unit: String.t(),
          timezone: String.t()
        }

  defstruct [
    :current,
    :daily,
    :forecast_days,
    :hourly,
    :latitude,
    :longitude,
    :precipitation_unit,
    :temperature_unit,
    :wind_speed_unit,
    timezone: "auto"
  ]
end
