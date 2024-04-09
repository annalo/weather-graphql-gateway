defmodule WeatherGraphqlGateway.OpenMeteoAPI.Models.DailyWeatherTest do
  use ExUnit.Case

  alias WeatherGraphqlGateway.OpenMeteoAPI.Models.DailyWeather

  describe "struct creation" do
    test "can create a DailyWeather struct with all fields" do
      daily_weather = %DailyWeather{
        precipitation_probability_max: [26, 0, 0],
        sunrise: ["2024-01-01T06:56", "2024-01-02T06:55", "2024-01-03T06:53"],
        sunset: ["2024-01-01T19:39", "2024-01-02T19:40", "2024-01-03T19:41"],
        temperature_2m_max: [54.8, 58.7, 57.5],
        temperature_2m_min: [42.7, 38.7, 35],
        time: ["2024-01-01", "2024-01-02", "2024-01-03"],
        weather_code: [3, 3, 3]
      }

      assert daily_weather.precipitation_probability_max == [26, 0, 0]
      assert daily_weather.sunrise == ["2024-01-01T06:56", "2024-01-02T06:55", "2024-01-03T06:53"]
      assert daily_weather.sunset == ["2024-01-01T19:39", "2024-01-02T19:40", "2024-01-03T19:41"]
      assert daily_weather.temperature_2m_min == [42.7, 38.7, 35]
      assert daily_weather.temperature_2m_max == [54.8, 58.7, 57.5]
      assert daily_weather.time == ["2024-01-01", "2024-01-02", "2024-01-03"]
      assert daily_weather.weather_code == [3, 3, 3]
    end

    test "can create a DailyWeather struct with some fields" do
      daily_weather = %DailyWeather{
        temperature_2m_max: [54.8, 58.7, 57.5],
        temperature_2m_min: [42.7, 38.7, 35],
        time: ["2024-01-01", "2024-01-02", "2024-01-03"],
      }

      assert daily_weather.temperature_2m_min == [42.7, 38.7, 35]
      assert daily_weather.temperature_2m_max == [54.8, 58.7, 57.5]
      assert daily_weather.time == ["2024-01-01", "2024-01-02", "2024-01-03"]
      assert daily_weather.precipitation_probability_max == nil
      assert daily_weather.sunrise == nil
      assert daily_weather.sunset == nil

      assert daily_weather.weather_code == nil
    end

    test "can create an empty DailyWeather struct" do
      daily_weather = %DailyWeather{}

      assert daily_weather.precipitation_probability_max == nil
      assert daily_weather.sunrise == nil
      assert daily_weather.sunset == nil
      assert daily_weather.temperature_2m_max == nil
      assert daily_weather.temperature_2m_min == nil
      assert daily_weather.time == nil
      assert daily_weather.weather_code == nil
    end
  end
end
