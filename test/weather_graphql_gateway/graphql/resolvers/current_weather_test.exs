defmodule WeatherGraphqlGateway.Graphql.Resolvers.CurrentWeatherTest do
  use ExUnit.Case

  alias WeatherGraphqlGateway.Graphql.Resolvers.CurrentWeather

  describe "get_data" do
    test "returns current weather parameters" do
      parent = %{
        latitude: 25.0340,
        longitude: 121.5645,
        temperature_unit: "fahrenheit",
        precipitation_unit: "inch",
        wind_speed_unit: "mph",
        fields: ["is_day", "cloud_cover"]
      }

      {:ok, resolution} = CurrentWeather.get_data(parent, nil, nil)

      assert resolution.cloud_cover |> is_integer() == true
      assert resolution.is_day |> is_integer() == true
    end
  end
end
