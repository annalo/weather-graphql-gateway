defmodule WeatherGraphqlGateway.Schema do
  use Absinthe.Schema

  enum :precipitation_unit do
    description "The precipitation unit"
    value :mm, description: "mm"
    value :inch, description: "inch"
  end

  enum :temperature_unit do
    description "The temperature unit"
    value :celsius, description: "Celsius"
    value :fahrenheit, description: "Fahrenheit"
  end

  enum :wind_speed_unit do
    description "The wind speed unit"
    value :kmh, description: "khm"
    value :ms, description: "ms"
    value :mph, description: "mph"
    value :kn, description: "kn"
  end

  object :daily do
    @desc "The max precipitation probability (in percentage)."
    field :precipitation_probability, :integer
    @desc "The time of sunrise. (in local timezone)"
    field :sunrise, :string
    @desc "The time of sunset. (in local timezone)"
    field :sunset, :string
    @desc "The maximum air temperature. (C/F)"
    field :temperature_max, :float
    @desc "The minimum air temperature. (C/F)"
    field :temperature_min, :float
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
    field :relative_humidity, :integer
    @desc "Time the temperature was taken."
    field :time, :string
    @desc "The air temperature. (C/F)"
    field :temperature, :float
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
    field :temperature, :float
    @desc "The time of the hourly weather data. (YYYY-MM-ddThh:mm i.e. 2024-01-01T00:00)"
    field :time, :string
    @desc "Weather condition as a numeric code. Follow WMO weather interpretation codes."
    field :weather_code, :integer

  end

  query do
    field :latitude, non_null(:float)
    field :longitude, non_null(:float)

    @desc "The number of days to include in the daily forecast. Defaults to 7."
    field :forecast_days, :integer
    @desc "The unit of measurement for precipitation. Defaults to mm. (mm/inch)"
    field :precipitation_unit, :precipitation_unit
    @desc "The unit of measurement for temperature. Defaults to Celsius. (celsius/fahrenheit)"
    field :temperature_unit, :temperature_unit
    @desc "The unit of measurement for wind speed. Defaults to kmh. (kmh, ms, mph, kn)"
    field :wind_speed_unit, :wind_speed_unit
    @desc "Daily weather data for the specified `forecast_days` field. Defaults to 7 days."
    field :daily, list_of(:daily)
    @desc "Hourly data for the day (24h)."
    field :hourly, list_of(:hourly)
    @desc "Current weather data."
    field :current, :current
  end
end
