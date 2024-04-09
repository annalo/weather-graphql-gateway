defmodule WeatherGraphqlGateway.OpenMeteoAPI.GraphqlSerializerTest do
  use ExUnit.Case

  alias WeatherGraphqlGateway.OpenMeteoApi.GraphqlSerializer

  describe "serialize_daily_weather/1" do
    test "serializes daily weather data" do
      data = %{
        precipitation_probability_max: [26, 0, 0, 0, 16, 26, 39],
        sunrise: ["2024-01-01T06:56", "2024-04-05T06:55", "2024-04-06T06:53",
         "2024-04-07T06:52", "2024-04-08T06:50", "2024-04-09T06:49",
         "2024-04-10T06:48"],
        sunset: ["2024-01-01T19:39", "2024-04-05T19:40", "2024-04-06T19:41",
         "2024-04-07T19:42", "2024-04-08T19:43", "2024-04-09T19:44",
         "2024-04-10T19:44"],
        temperature_2m_max: [54.8, 58.7, 57.5, 63.2, 70.3, 73.3, 71.1],
        temperature_2m_min: [42.7, 38.7, 35, 35.5, 42.5, 55, 58.8],
        time: ["2024-01-01", "2024-04-05", "2024-04-06", "2024-04-07",
         "2024-04-08", "2024-04-09", "2024-04-10"],
        weather_code: [3, 3, 3, 3, 3, 53, 51]
      }

      serialized_list = GraphqlSerializer.serialize_daily_weather(data)
      first = Enum.at(serialized_list, 0)

      assert first.precipitation_probability_max == 26
      assert first.sunrise == "2024-01-01T06:56"
      assert first.sunset == "2024-01-01T19:39"
      assert first.temperature_2m_max == 54.8
      assert first.temperature_2m_min == 42.7
      assert first.time == "2024-01-01"
      assert first.weather_code == 3
    end
  end

  describe "serialize_hourly_weather/1" do
    test "serializes hourly weather data" do
      data = %{
        time: ["2024-01-01T00:00", "2024-01-01T01:00", "2024-01-01T02:00",
          "2024-01-01T03:00", "2024-01-01T04:00", "2024-01-01T05:00",
          "2024-01-01T06:00", "2024-01-01T07:00", "2024-01-01T08:00",
          "2024-01-01T09:00", "2024-01-01T10:00", "2024-01-01T11:00",
          "2024-01-01T12:00", "2024-01-01T13:00", "2024-01-01T14:00",
          "2024-01-01T15:00", "2024-01-01T16:00", "2024-01-01T17:00",
          "2024-01-01T18:00", "2024-01-01T19:00", "2024-01-01T20:00",
          "2024-01-01T21:00", "2024-01-01T22:00", "2024-01-01T23:00"],
        weather_code: [0, 0, 0, 0, 0, 0, 0, 2, 0, 3, 2, 1, 1, 2, 3, 3, 3, 3, 3, 0,
          0, 0, 0, 0],
        is_day: [0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0,
          0, 0],
        precipitation_probability: [0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 4, 6, 4, 2, 0, 9,
          17, 26, 18, 11, 3, 2, 1, 0],
        temperature_2m: [53.3, 50.9, 48.7, 47, 45.6, 44.4, 43.4, 43.2, 44.9, 47.1,
          52, 52.7, 53.8, 54.7, 55.2, 54.1, 53.4, 53.4, 51.5, 49.8, 47.1, 44.7, 43.3,
          42.3]
      }

      serialized_list = GraphqlSerializer.serialize_hourly_weather(data)
      first = Enum.at(serialized_list, 0)

      assert first.time == "2024-01-01T00:00"
      assert first.is_day == 0
      assert first.precipitation_probability == 0
      assert first.temperature_2m == 53.3
      assert first.weather_code == 0
    end
  end
end
