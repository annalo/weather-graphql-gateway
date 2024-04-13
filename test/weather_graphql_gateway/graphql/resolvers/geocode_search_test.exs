defmodule WeatherGraphqlGateway.Graphql.Resolvers.GeocodeSearchTest do
  use ExUnit.Case

  alias WeatherGraphqlGateway.Graphql.Resolvers.GeocodeSearch

  describe "GeocodeSearch.query" do
    test "returns list of geocodes" do
      {:ok, resolution} =
        GeocodeSearch.query(
          %{language: "en"},
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
