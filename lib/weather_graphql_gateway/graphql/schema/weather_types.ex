defmodule WeatherGraphqlGateway.Graphql.Schema.WeatherTypes do
  @moduledoc """
  This module defines GraphQL object types representing different weather data types.
  """
  use Absinthe.Schema.Notation

  object :daily do
    @desc "The max precipitation probability (in percentage)."
    field :precipitation_probability_max, :integer
    @desc "The time of sunrise. (in local timezone)"
    field :sunrise, :string
    @desc "The time of sunset. (in local timezone)"
    field :sunset, :string
    @desc "The maximum air temperature. (C/F)"
    field :temperature_2m_max, :float
    @desc "The minimum air temperature. (C/F)"
    field :temperature_2m_min, :float
    @desc "The date of the weather"
    field :time, :string
    @desc "Weather condition as a numeric code. Follow WMO weather interpretation codes."
    field :weather_code, :integer
  end

  object :current do
    @desc "Perceived feels-like temperature combining wind chill factor, relative humidity and solar radiation. (C/F)"
    field :apparent_temperature, :float
    @desc "Total cloud cover as an area fraction. (in percentage)"
    field :cloud_cover, :integer
    @desc "1 if the current time step has daylight, 0 at night."
    field :is_day, :integer
    @desc "Total current precipitation (rain, showers, snow) sum. (mm/inch)"
    field :precipitation, :integer
    @desc "The relative humidity. (in percentage)"
    field :relative_humidity_2m, :integer
    @desc "Time the temperature was taken."
    field :time, :string
    @desc "The air temperature. (C/F)"
    field :temperature_2m, :float
    @desc "Weather condition as a numeric code. Follow WMO weather interpretation codes."
    field :weather_code, :integer
    @desc "The wind speed at 10 meters above ground level. 10 meters is the standard level. (km/h, mph, m/s, knots)"
    field :wind_speed_10m, :float
  end

  object :hourly do
    @desc "1 if the current time step has daylight, 0 at night."
    field :is_day, :integer
    @desc "The precipitation probability. (in percentage)"
    field :precipitation_probability, :integer
    @desc "The air temperature at 2 meters above ground level. (C/F)"
    field :temperature_2m, :float
    @desc "The time of the hourly weather data. (YYYY-MM-ddThh:mm i.e. 2024-01-01T00:00)"
    field :time, :string
    @desc "Weather condition as a numeric code. Follow WMO weather interpretation codes."
    field :weather_code, :integer
  end
end
