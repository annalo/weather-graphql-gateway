defmodule WeatherGraphqlGateway.NominatimAPI.GraphqlAdapterTest do
  use ExUnit.Case

  alias WeatherGraphqlGateway.NominatimAPI.GraphqlAdapter

  describe "GraphqlAdapter.geocode/1" do
    test "queries and returns location results" do
      locations = GraphqlAdapter.geocode("Copenhagen")
      first = Enum.at(locations, 0)

      assert first["name"] == "København"
      assert first["lat"] == "55.6867243"
      assert first["lon"] == "12.5700724"
    end
  end
end
