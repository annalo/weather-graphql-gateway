defmodule WeatherGraphqlGateway.OpenMeteoAPI.ClientTest do
  use ExUnit.Case

  alias WeatherGraphqlGateway.OpenMeteoAPI.Client
  alias WeatherGraphqlGateway.OpenMeteoAPI.Models.WeatherRequest

  describe "Client.get_weather" do
    test "gets weather data for a valid request" do
      request = %WeatherRequest{
        latitude: 35.8317,
        longitude: -78.9286,
        current: ["temperature_2m"],
        daily: ["weather_code"],
        hourly: ["precipitation_probability"],
        forecast_days: 1
      }
      response = Client.get_weather(request)

      assert response["latitude"] == 35.823345
      assert response["longitude"] == -78.93414
      assert response["timezone"] == "America/New_York"
      assert response["timezone_abbreviation"] == "EDT"
      assert response["current"]["temperature_2m"] |> is_number() == true
      assert response["hourly"]["precipitation_probability"] |> length() == 24
      assert response["daily"]["weather_code"] |> length() == 1
    end

    test "handles error exception" do
      request = %WeatherRequest{
        latitude: 35.8317,
        longitude: "asdf",
      }
      response = Client.get_weather(request)
      assert response["reason"] == "Data corrupted at path ''. Cannot initialize Float from invalid String value asdf."
    end
  end

  describe "Client.build_url" do
    test "with all parameters" do
      request = %WeatherRequest{
        latitude: 35.7326,
        longitude: 78.8503,
        current: ["temperature_2m"],
        daily: ["weather_code", "temperature_2m_max", "temperature_2m_min", "sunrise", "sunset", "precipitation_probability_max"],
        hourly: ["temperature_2m", "precipitation_probability", "weather_code", "is_day"],
        precipitation_unit: "inch",
        temperature_unit: "fahrenheit",
        wind_speed_unit: "mph",
        timezone: "America/New_York",
        forecast_days: 3
      }

      uri = Client.build_url(request) |> URI.parse()
      query = URI.decode_query(uri.query)

      assert query["current[]"] == "temperature_2m"
      assert query["daily[]"] == "precipitation_probability_max"
      assert query["forecast_days"] == "3"
      assert query["hourly[]"] == "is_day"
      assert query["latitude"] == "35.7326"
      assert query["longitude"] == "78.8503"
      assert query["precipitation_unit"] == "inch"
      assert query["temperature_unit"] == "fahrenheit"
      assert query["timezone"] == "America/New_York"
      assert query["wind_speed_unit"] == "mph"
    end

    test "removes keys with nil value" do
      request = %WeatherRequest{
        latitude: 35.7326,
        longitude: -78.8503,
        current: ["temperature_2m"],
        temperature_unit: "fahrenheit"
      }

      uri = Client.build_url(request) |> URI.parse()
      query = URI.decode_query(uri.query)

      assert Enum.count(query) == 5 #includes timezone by default
      assert query["current[]"] == "temperature_2m"
      assert query["latitude"] == "35.7326"
      assert query["longitude"] == "-78.8503"
      assert query["temperature_unit"] == "fahrenheit"
    end
  end
end
