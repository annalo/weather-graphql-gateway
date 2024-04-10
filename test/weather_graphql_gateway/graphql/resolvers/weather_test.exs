defmodule WeatherGraphqlGateway.Graphql.Resolvers.WeatherTest do
  use ExUnit.Case

  alias WeatherGraphqlGateway.Graphql.Resolvers.Weather

  describe "get_data" do
    test "returns :ok response with args" do
      args = %{
        latitude: 35.7279,
        longitude: -78.85654,
        temperature_unit: "fahrenheit",
        precipitation_unit: "inch",
        wind_speed_unit: "mph",
      }

      {:ok, resolution} = Weather.get_data(nil, args, nil)

      assert resolution == args
    end
  end
end
