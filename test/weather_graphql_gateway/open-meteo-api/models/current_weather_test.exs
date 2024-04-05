defmodule WeatherGraphqlGateway.OpenMeteoAPI.Models.CurrentWeatherTest do
  use ExUnit.Case

  alias WeatherGraphqlGateway.OpenMeteoAPI.Models.CurrentWeather

  describe "struct creation" do
    test "can create a CurrentWeather struct with all fields" do
      current_weather = %CurrentWeather{
        apparent_temperature: 20.5,
        cloud_cover: 75,
        is_day: 1,
        precipitation: 0.2,
        relative_humidity_2m: 65,
        temperature_2m: 22.0,
        time: "2024-04-04T16:15",
        weather_code: 3,
        wind_speed_10m: 8.0
      }

      assert current_weather.apparent_temperature == 20.5
      assert current_weather.cloud_cover == 75
      assert current_weather.is_day == 1
      assert current_weather.precipitation == 0.2
      assert current_weather.relative_humidity_2m == 65
      assert current_weather.temperature_2m == 22.0
      assert current_weather.time == "2024-04-04T16:15"
      assert current_weather.weather_code == 3
      assert current_weather.wind_speed_10m == 8.0
    end

    test "can create a CurrentWeather struct with some fields" do
      current_weather = %CurrentWeather{
        temperature_2m: 18.0,
        wind_speed_10m: 5.0
      }

      assert current_weather.temperature_2m == 18.0
      assert current_weather.wind_speed_10m == 5.0
      assert current_weather.apparent_temperature == nil
      assert current_weather.cloud_cover == nil
      assert current_weather.is_day == nil
      assert current_weather.precipitation == nil
      assert current_weather.relative_humidity_2m == nil
      assert current_weather.time == nil
      assert current_weather.weather_code == nil
    end

    test "can create an empty CurrentWeather struct" do
      current_weather = %CurrentWeather{}

      assert current_weather.apparent_temperature == nil
      assert current_weather.cloud_cover == nil
      assert current_weather.is_day == nil
      assert current_weather.precipitation == nil
      assert current_weather.relative_humidity_2m == nil
      assert current_weather.temperature_2m == nil
      assert current_weather.time == nil
      assert current_weather.weather_code == nil
      assert current_weather.wind_speed_10m == nil
    end
  end
end
