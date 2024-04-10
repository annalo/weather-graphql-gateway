defmodule WeatherGraphqlGateway.OpenMeteoAPI.GraphqlAdapterTest do
  use ExUnit.Case

  alias WeatherGraphqlGateway.OpenMeteoApi.GraphqlAdapter

  describe "request_current_weather" do
    test "fetches and returns current weather" do
      request =
        GraphqlAdapter.request_current_weather(%{
          latitude: 35.7279,
          longitude: -78.85654,
          temperature_unit: "fahrenheit",
          precipitation_unit: "inch",
          wind_speed_unit: "mph",
          fields: [
            "apparent_temperature",
            "cloud_cover",
            "is_day",
            "precipitation",
            "relative_humidity_2m",
            "temperature_2m",
            "weather_code",
            "wind_speed_10m"
          ]
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
      request =
        GraphqlAdapter.request_daily_weather(%{
          latitude: 35.7279,
          longitude: -78.85654,
          temperature_unit: "celsius",
          precipitation_unit: "mm",
          wind_speed_unit: "kmh",
          forecast_days: 7,
          fields: [
            "precipitation_probability_max",
            "sunrise",
            "sunset",
            "temperature_2m_max",
            "temperature_2m_min",
            "weather_code"
          ]
        })

      first = Enum.at(request, 0)

      assert length(request) == 7
      assert first.precipitation_probability_max |> is_number() == true
      assert first.sunrise |> is_binary() == true
      assert first.sunset |> is_binary() == true
      assert first.temperature_2m_max |> is_number() == true
      assert first.temperature_2m_min |> is_number() == true
      assert first.time |> is_binary() == true
      assert first.weather_code |> is_integer() == true
    end
  end

  describe "request_hourly_weather" do
    test "fetches and returns hourly weather" do
      request =
        GraphqlAdapter.request_hourly_weather(%{
          latitude: 35.7279,
          longitude: -78.85654,
          temperature_unit: "fahrenheit",
          precipitation_unit: "inch",
          wind_speed_unit: "mph",
          forecast_days: 1,
          fields: ["is_day", "precipitation_probability", "temperature_2m", "weather_code"]
        })

      first = Enum.at(request, 0)

      assert length(request) == 24
      assert first.is_day |> is_integer() == true
      assert first.precipitation_probability |> is_integer() == true
      assert first.temperature_2m |> is_number() == true
      assert first.time |> is_binary() == true
      assert first.weather_code |> is_integer() == true
    end
  end
end
