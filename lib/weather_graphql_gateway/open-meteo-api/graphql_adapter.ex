defmodule WeatherGraphqlGateway.OpenMeteoApi.GraphqlAdapter do
  @spec request_current_weather(number(), number(), String.t(), String.t(), String.t()) :: nil
  def request_current_weather(
    _latitude,
    _longitude,
    _precipitation_unit,
    _temperature_unit,
    _wind_speed_unit
  ) do

  end

  @spec request_daily_weather(number(), number(), String.t(), String.t(), String.t(), integer()) :: nil
  def request_daily_weather(
    _latitude,
    _longitude,
    _precipitation_unit,
    _temperature_unit,
    __wind_speed_unit,
    _days
  ) do

  end

  @spec request_hourly_weather(number(), number(), String.t(), String.t(), String.t(), integer()) :: nil
  def request_hourly_weather(
    _latitude,
    _longitude,
    _precipitation_unit,
    _temperature_unit,
    __wind_speed_unit,
    _hours
  ) do

  end
end
