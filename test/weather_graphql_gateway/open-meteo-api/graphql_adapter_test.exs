defmodule WeatherGraphqlGateway.OpenMeteoAPI.GraphqlAdapterTest do
  use ExUnit.Case

  alias WeatherGraphqlGateway.OpenMeteoApi.GraphqlAdapter

  describe "request_current_weather" do
    test "fetches and returns current weather" do
      request = GraphqlAdapter.request_current_weather(%{
        latitude: 35.7279,
        longitude: -78.85654,
        temperature_unit: "fahrenheit",
        precipitation_unit: "inch",
        wind_speed_unit: "mph"
      })

      assert request.apparent_temperature |> is_number == true
      assert request.cloud_cover |> is_integer == true
      assert request.interval |> is_integer == true
      assert request.is_day |> is_integer == true
      assert request.precipitation |> is_number == true
      assert request.relative_humidity_2m |> is_integer == true
      assert request.temperature_2m |> is_number == true
      assert request.time |> is_binary == true
      assert request.weather_code |> is_integer == true
      assert request.wind_speed_10m |> is_number == true
    end
  end

  describe "request_daily_weather" do
    test "fetches and returns daily weather" do
      request = GraphqlAdapter.request_daily_weather(%{
        latitude: 35.7279,
        longitude: -78.85654,
        temperature_unit: "celsius",
        precipitation_unit: "mm",
        wind_speed_unit: "kmh",
        forecast_days: 7
      })

      assert request.precipitation_probability_max |> length() == 7
      assert request.sunrise |> length() == 7
      assert request.sunset |> length() == 7
      assert request.temperature_2m_max |> length() == 7
      assert request.temperature_2m_min |> length() == 7
      assert request.time |> length() == 7
      assert request.weather_code |> length() == 7
    end
  end

  describe "request_hourly_weather" do
    test "fetches and returns hourly weather" do
      request = GraphqlAdapter.request_hourly_weather(%{
        latitude: 35.7279,
        longitude: -78.85654,
        temperature_unit: "fahrenheit",
        precipitation_unit: "inch",
        wind_speed_unit: "mph",
        forecast_days: 1
      })

      assert request.is_day |> length() == 24
      assert request.precipitation_probability |> length() == 24
      assert request.temperature_2m |> length() == 24
      assert request.time |> length() == 24
      assert request.weather_code |> length() == 24
    end
  end
end
