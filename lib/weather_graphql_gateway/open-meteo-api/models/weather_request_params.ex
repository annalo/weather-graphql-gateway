defmodule WeatherGraphqlGateway.OpenMeteoAPI.Models.WeatherRequestParams do
  @moduledoc """
  Represents the query parameters for requesting weather data from the Open Meteo API.
  """

  @type t :: %__MODULE__{
          latitude: number(),
          longitude: number(),
          hourly: [String.t()],
          daily: [String.t()],
          current: [String.t()],
          temperature_unit: String.t(),
          wind_speed_unit: String.t(),
          precipitation_unit: String.t(),
          timezone: String.t(),
          forecast_days: integer(),
          start_hour: String.t(),
          end_hour: String.t(),
          start_minutely_15: String.t(),
          end_minutely_15: String.t(),
          apikey: String.t()
        }

  defstruct [
    :latitude,
    :longitude,
    :hourly,
    :daily,
    :current,
    :temperature_unit,
    :wind_speed_unit,
    :precipitation_unit,
    :timezone,
    :forecast_days,
    :start_hour,
    :end_hour,
    :start_minutely_15,
    :end_minutely_15,
    :apikey
  ]

  @doc """
  Constructs a new weather request params struct.

  ## Parameters

  - `latitude`: The latitude coordinate for the location.
  - `longitude`: The longitude coordinate for the location.
  - `hourly`: (optional) A list of hourly weather variables which should be returned.
  - `daily`: (optional) A list of weather variables to get current conditions.
  - `current`: (optional) Whether to include current weather data. Defaults to true.
  - `temperature_unit`: (optional) The unit of measurement for temperature. Defaults to Celsius.
  - `wind_speed_unit`: (optional) The unit of measurement for wind speed. Defaults to kmh.
  - `precipitation_unit`: (optional) The unit of measurement for precipitation. Defaults to "mm".
  - `timezone`: (optional) If auto is set, coordinates will be automatically resolved to local time zone.
  - `forecast_days`: (optional) The number of days to include in the forecast. Defaults to 7.
  - `start_hour`: (optional) The start time for hourly or 15-minute data updates. Format: "yyyy-mm-ddThh:mm".
  - `end_hour`: (optional) The end time for hourly or 15-minute data updates. Format: "yyyy-mm-ddThh:mm".
  - `start_minutely_15`: (optional) The start time for 15-minute data updates. Format: "yyyy-mm-ddThh:mm".
  - `end_minutely_15`: (optional) The end time for 15-minute data updates. Format: "yyyy-mm-ddThh:mm".
  - `apikey`: (optional) The API key for accessing the Open Meteo API.
  """

  def new(
    latitude,
    longitude,
    hourly,
    daily,
    current,
    temperature_unit,
    wind_speed_unit,
    precipitation_unit,
    timezone,
    forecast_days,
    start_hour,
    end_hour,
    start_minutely_15,
    end_minutely_15,
    apikey
  ) do
    %__MODULE__{
      latitude: latitude,
      longitude: longitude,
      hourly: hourly,
      daily: daily,
      current: current,
      temperature_unit: temperature_unit,
      wind_speed_unit: wind_speed_unit,
      precipitation_unit: precipitation_unit,
      timezone: timezone,
      forecast_days: forecast_days,
      start_hour: start_hour,
      end_hour: end_hour,
      start_minutely_15: start_minutely_15,
      end_minutely_15: end_minutely_15,
      apikey: apikey
    }
  end
end
