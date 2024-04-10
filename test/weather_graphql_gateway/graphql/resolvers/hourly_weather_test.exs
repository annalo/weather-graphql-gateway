defmodule WeatherGraphqlGateway.Graphql.Resolvers.HourlyWeatherTest do
  use ExUnit.Case

  alias WeatherGraphqlGateway.Graphql.Resolvers.HourlyWeather

  describe "get_data" do
    test "returns list of hourly weather" do
      parent = %{
        latitude: 35.7279,
        longitude: -78.85654,
        temperature_unit: "fahrenheit",
        precipitation_unit: "inch",
        wind_speed_unit: "mph",
        fields: ["apparent_temperature", "precipitation"]
      }

      args = %{forecast_days: 1}

      {:ok, resolution} = HourlyWeather.get_data(parent, args, nil)

      # 24 hours in 1 day
      assert length(resolution) == 24
    end
  end
end
