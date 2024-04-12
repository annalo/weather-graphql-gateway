defmodule WeatherGraphqlGateway.Graphql.Resolvers.DailyWeatherTest do
  use ExUnit.Case

  alias WeatherGraphqlGateway.Graphql.Resolvers.DailyWeather

  describe "get_data" do
    test "returns list of daily weather" do
      parent = %{
        latitude: 25.0340,
        longitude: 121.5645,
        temperature_unit: "fahrenheit",
        precipitation_unit: "inch",
        wind_speed_unit: "mph",
        fields: ["temperature_2m_max", "temperature_2m_min"]
      }

      args = %{forecast_days: 2}

      {:ok, resolution} = DailyWeather.get_data(parent, args, nil)

      # 2 days
      assert length(resolution) == 2
    end
  end
end
