defmodule WeatherGraphqlGateway.OpenMeteoAPI.Models.WeatherRequestTest do
  use ExUnit.Case

  alias WeatherGraphqlGateway.OpenMeteoAPI.Models.WeatherRequest

  describe "struct creation" do
    test "can create a WeatherRequest struct with all the fields" do
      request = %WeatherRequest{
        latitude: 35.7326,
        longitude: 78.8503,
        current: [
          "temperature_2m",
          "relative_humidity_2m",
          "apparent_temperature",
          "is_day",
          "precipitation",
          "weather_code",
          "cloud_cover",
          "wind_speed_10m"
        ],
        hourly: ["temperature_2m", "precipitation_probability", "weather_code", "is_day"],
        daily: [
          "weather_code",
          "temperature_2m_max",
          "temperature_2m_min",
          "sunrise",
          "sunset",
          "precipitation_probability_max"
        ],
        temperature_unit: "fahrenheit",
        wind_speed_unit: "mph",
        precipitation_unit: "inch",
        timezone: "America/New_York",
        forecast_days: 3
      }

      assert request.latitude == 35.7326
      assert request.longitude == 78.8503

      assert request.current == [
               "temperature_2m",
               "relative_humidity_2m",
               "apparent_temperature",
               "is_day",
               "precipitation",
               "weather_code",
               "cloud_cover",
               "wind_speed_10m"
             ]

      assert request.hourly == [
               "temperature_2m",
               "precipitation_probability",
               "weather_code",
               "is_day"
             ]

      assert request.daily == [
               "weather_code",
               "temperature_2m_max",
               "temperature_2m_min",
               "sunrise",
               "sunset",
               "precipitation_probability_max"
             ]

      assert request.temperature_unit == "fahrenheit"
      assert request.wind_speed_unit == "mph"
      assert request.precipitation_unit == "inch"
      assert request.timezone == "America/New_York"
      assert request.forecast_days == 3
    end

    test "can create a CurrentWeather struct without optional fields" do
      request = %WeatherRequest{
        latitude: 35.7326,
        longitude: 78.8503
      }

      assert request.latitude == 35.7326
      assert request.longitude == 78.8503
      assert request.current == nil
      assert request.hourly == nil
      assert request.daily == nil
      assert request.timezone == "auto"
    end
  end
end
