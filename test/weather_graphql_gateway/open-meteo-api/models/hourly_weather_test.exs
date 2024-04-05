defmodule WeatherGraphqlGateway.OpenMeteoAPI.Models.HourlyWeatherTest do
  use ExUnit.Case

  alias WeatherGraphqlGateway.OpenMeteoAPI.Models.HourlyWeather

  describe "struct creation" do
    test "can create a HourlyWeather struct with all fields" do
      hourly_weather = %HourlyWeather{
        is_day: [1, 0],
        precipitation_probability: [25.0, 50.0],
        temperature_2m: [20.5, 18.0],
        time: ["2024-01-01T00:00", "2024-01-01T01:00"],
        weather_code: [3, 2]
      }

      assert hourly_weather.is_day == [1, 0]
      assert hourly_weather.precipitation_probability == [25.0, 50.0]
      assert hourly_weather.temperature_2m == [20.5, 18.0]
      assert hourly_weather.time == ["2024-01-01T00:00", "2024-01-01T01:00"]
      assert hourly_weather.weather_code == [3, 2]
    end

    test "can create a HourlyWeather struct with some fields" do
      hourly_weather = %HourlyWeather{
        temperature_2m: [18.0],
        weather_code: [2]
      }

      assert hourly_weather.temperature_2m == [18.0]
      assert hourly_weather.weather_code == [2]
      assert hourly_weather.is_day == nil
      assert hourly_weather.precipitation_probability == nil
      assert hourly_weather.time == nil
    end

    test "can create an empty HourlyWeather struct" do
      hourly_weather = %HourlyWeather{}

      assert hourly_weather.is_day == nil
      assert hourly_weather.precipitation_probability == nil
      assert hourly_weather.temperature_2m == nil
      assert hourly_weather.time == nil
      assert hourly_weather.weather_code == nil
    end
  end
end
