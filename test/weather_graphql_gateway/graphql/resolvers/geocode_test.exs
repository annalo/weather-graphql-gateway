defmodule WeatherGraphqlGateway.Graphql.Resolvers.GeocodeTest do
  use ExUnit.Case

  alias WeatherGraphqlGateway.Graphql.Resolvers.Geocode

  describe "Geocode.query" do
    test "returns list of geocodes" do
      {:ok, resolution} =
        Geocode.query(
          nil,
          %{query: "Amsterdam", limit: 2},
          nil
        )

      first = Enum.at(resolution, 0)

      assert length(resolution) == 2
      assert first.name == "Amsterdam"
      assert first.lat == 52.3730796
      assert first.lon == 4.8924534
    end
  end
end
