defmodule WeatherGraphqlGateway.Graphql.Schema.WeatherTypes do
  @moduledoc """
  This module defines GraphQL object types representing different weather data types.

  ## Object Types

  ### weather
  - `latitude` (float)
  - `longitude` (float)
  - `precipitation_unit` (string)
  - `temperature_unit` (string)
  - `wind_speed_unit` (string)
  - `current` (:current)
  - `daily` (list_of(:daily))
  - `hourly` (list_of(:hourly))

  ### current
  - `apparent_temperature` (float)
  - `cloud_cover` (integer)
  - `is_day` (integer)
  - `precipitation` (float)
  - `relative_humidity` (integer)
  - `time` (string)
  - `temperature` (float)
  - `weather_code` (integer)
  - `wind_speed` (float)

  ### daily
  - `precipitation_probability` (integer)
  - `sunrise` (string)
  - `sunset` (string)
  - `temperature_max` (float)
  - `temperature_min` (float)
  - `date` (string)
  - `weather_code` (integer)

  ### hourly
  - `is_day` (integer)
  - `precipitation_probability` (integer)
  - `temperature` (float)
  - `time` (string)
  - `weather_code` (integer)
  """

  use Absinthe.Schema.Notation
  alias WeatherGraphqlGateway.Graphql.Resolvers

  object :weather do
    field(:latitude, :float)
    field(:longitude, :float)
    field(:precipitation_unit, :string)
    field(:temperature_unit, :string)
    field(:wind_speed_unit, :string)

    @desc "Current weather data."
    field :current, :current do
      resolve(&Resolvers.CurrentWeather.get_data/3)
    end

    @desc "Daily weather data. Defaults to 7 days."
    field :daily, list_of(:daily) do
      @desc "Per default, only 7 days are returned. Up to 16 days of forecast are possible."
      arg(:forecast_days, :integer, default_value: 7)
      resolve(&Resolvers.DailyWeather.get_data/3)
    end

    @desc "Hourly data. Defaults to today's 24h."
    field :hourly, list_of(:hourly) do
      @desc "Per default, today's 24h is returned. Up to 16 days of forecast are possible."
      arg(:forecast_days, :integer, default_value: 1)
      resolve(&Resolvers.HourlyWeather.get_data/3)
    end
  end

  object :current do
    @desc "Perceived feels-like temperature combining wind chill factor, relative humidity and solar radiation. (C/F)"
    field(:apparent_temperature, :float)
    @desc "Total cloud cover as an area fraction. (in percentage)"
    field(:cloud_cover, :integer)
    @desc "1 if the current time step has daylight, 0 at night."
    field(:is_day, :integer)
    @desc "Total current precipitation (rain, showers, snow) sum. (mm/inch)"
    field(:precipitation, :float)
    @desc "The relative humidity. (in percentage)"
    field(:relative_humidity_2m, :integer, name: "relative_humidity")
    @desc "Time the temperature was taken."
    field(:time, :string)
    @desc "The air temperature. (C/F)"
    field(:temperature_2m, :float, name: "temperature")
    @desc "Weather condition as a numeric code. Follow WMO weather interpretation codes."
    field(:weather_code, :integer)
    @desc "The wind speed at 10 meters above ground level. 10 meters is the standard level. (km/h, mph, m/s, knots)"
    field(:wind_speed_10m, :float, name: "wind_speed")
  end

  object :daily do
    @desc "The precipitation probability (in percentage)."
    field(:precipitation_probability_max, :integer, name: "precipitation_probability")
    @desc "The time of sunrise. (in local timezone)"
    field(:sunrise, :string)
    @desc "The time of sunset. (in local timezone)"
    field(:sunset, :string)
    @desc "The maximum air temperature. (C/F)"
    field(:temperature_2m_max, :float, name: "temperature_max")
    @desc "The minimum air temperature. (C/F)"
    field(:temperature_2m_min, :float, name: "temperature_min")
    @desc "The date of the weather"
    field(:time, :string, name: "date")
    @desc "Weather condition as a numeric code. Follow WMO weather interpretation codes."
    field(:weather_code, :integer)
  end

  object :hourly do
    @desc "1 if the current time step has daylight, 0 at night."
    field(:is_day, :integer)
    @desc "The precipitation probability. (in percentage)"
    field(:precipitation_probability, :integer)
    @desc "The air temperature at 2 meters above ground level. (C/F)"
    field(:temperature_2m, :float, name: "temperature")
    @desc "The time of the hourly weather data. (YYYY-MM-ddThh:mm i.e. 2024-01-01T00:00)"
    field(:time, :string)
    @desc "Weather condition as a numeric code. Follow WMO weather interpretation codes."
    field(:weather_code, :integer)
  end
end
