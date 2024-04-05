defmodule WeatherGraphqlGateway.OpenMeteoAPI.ClientTest do
  use ExUnit.Case

  alias WeatherGraphqlGateway.OpenMeteoAPI.Client
  alias WeatherGraphqlGateway.OpenMeteoAPI.Models.WeatherRequest

  describe "Client.get_weather" do
    test "gets weather data for a valid request" do
      request = %WeatherRequest{latitude: 35.8317, longitude: -78.9286}
      {:ok, response} = Client.get_weather(request)

      # Assert
      assert Map.has_key?(response, :current_weather)
      assert Map.has_key?(response, :daily)
    end
  end

  describe "Client.build_url" do
    test "with all parameters" do
      request = %WeatherRequest{
        current: ["temperature_2m"],
        daily: ["weather_code", "temperature_2m_max", "temperature_2m_min", "sunrise", "sunset", "precipitation_probability_max"],
        forecast_days: 3,
        hourly: ["temperature_2m", "precipitation_probability", "weather_code", "is_day"],
        latitude: 35.7326,
        longitude: 78.8503,
        precipitation_unit: "inch",
        temperature_unit: "fahrenheit",
        timezone: "America/New_York",
        wind_speed_unit: "mph",
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
        current: ["temperature_2m"],
        latitude: 35.7326,
        longitude: -78.8503,
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

    # # Mock Req.get! for testing network errors
    # test "handles network error" do
    #   # Arrange
    #   request = %WeatherRequest{latitude: 35.8317, longitude: -78.9286}
    #   mock = fn _ -> {:error, :timeout} end

    #   defdelegate WeatherGraphqlGateway.OpenMeteoAPI.Client.get_weather(request), to: mock

    #   # Act
    #   assert_raise TimeoutError do
    #     WeatherGraphqlGateway.OpenMeteoAPI.Client.get_weather(request)
    #   end
    # end
end
