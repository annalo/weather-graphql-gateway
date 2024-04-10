defmodule WeatherGraphqlGateway.Graphql.Resolvers.DailyWeatherTest do
  use ExUnit.Case

  alias WeatherGraphqlGateway.Graphql.Resolvers.DailyWeather

  describe "get_data" do
    test "returns list of daily weather" do
      parent = %{
        latitude: 35.7279,
        longitude: -78.85654,
        temperature_unit: "fahrenheit",
        precipitation_unit: "inch",
        wind_speed_unit: "mph",
        fields: ["temperature_2m_max", "temperature_2m_min"]
      }
      args = %{forecast_days: 2}

      {:ok, resolution} = DailyWeather.get_data(parent, args, nil)

      assert length(resolution) == 2 # 2 days
    end
  end
end
