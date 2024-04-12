defmodule WeatherGraphqlGateway.OpenMeteoAPI.ClientTest do
  use ExUnit.Case

  alias WeatherGraphqlGateway.OpenMeteoAPI.Client
  alias WeatherGraphqlGateway.OpenMeteoAPI.Models.WeatherRequest

  describe "Client.get_weather/1" do
    test "gets weather data with a valid request" do
      request = %WeatherRequest{
        latitude: 25.03751988317,
        longitude: 121.56367969286,
        current: ["temperature_2m"],
        daily: ["weather_code"],
        hourly: ["precipitation_probability"],
        forecast_days: 1
      }

      response = Client.get_weather(request)

      assert response["latitude"] == 25.05
      assert response["longitude"] == 121.5625
      assert response["timezone"] == "Asia/Taipei"
      assert response["timezone_abbreviation"] == "CST"
      assert response["current"]["temperature_2m"] |> is_number() == true
      assert response["hourly"]["precipitation_probability"] |> length() == 24
      assert response["daily"]["weather_code"] |> length() == 1
    end
  end
end
