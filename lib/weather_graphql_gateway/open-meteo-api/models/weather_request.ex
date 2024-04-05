defmodule WeatherGraphqlGateway.OpenMeteoAPI.Models.WeatherRequest do
  @moduledoc """
  Represents the query parameters for requesting weather data from the Open Meteo API.

  ## Parameters

  - `latitude`: The latitude coordinate for the location.
  - `longitude`: The longitude coordinate for the location.
  - `daily`: (optional) A list of weather variables to get daily conditions.
  - `current`: (optional) Whether to include current weather data. Defaults to true.
  - `hourly`: (optional) A list of hourly weather variables which should be returned.
  - `temperature_unit`: (optional) The unit of measurement for temperature. Defaults to Celsius. (celsius/fahrenheit)
  - `wind_speed_unit`: (optional) The unit of measurement for wind speed. Defaults to kmh. (kmh, ms, mph, kn)
  - `precipitation_unit`: (optional) The unit of measurement for precipitation. Defaults to mm. (mm/inch)
  - `timezone`: (optional) By default set to "auto", coordinates will be automatically resolved to local time zone.
  - `forecast_days`: (optional) The number of days to include in the forecast. Defaults to 7.
  """
  @enforce_keys [:latitude, :longitude]
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
        }

  defstruct [
    :latitude,
    :longitude,
    :current,
    :hourly,
    :daily,
    temperature_unit: "celsius",
    wind_speed_unit: "kmh",
    precipitation_unit: "mm",
    timezone: "auto",
    forecast_days: 7
  ]
end
