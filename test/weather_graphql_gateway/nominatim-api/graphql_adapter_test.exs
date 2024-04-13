defmodule WeatherGraphqlGateway.NominatimAPI.GraphqlAdapterTest do
  use ExUnit.Case

  alias WeatherGraphqlGateway.NominatimAPI.GraphqlAdapter

  describe "GraphqlAdapter.geocode/1" do
    test "queries and returns geocode results" do
      geocodes = GraphqlAdapter.geocode("Copenhagen")
      first = Enum.at(geocodes, 0)

      assert first.name == "Copenhagen"
      assert first.lat == 55.6867243
      assert first.lon == 12.5700724
    end
  end

  describe "GraphqlAdapter.reverse_geocode/1" do
    test "queries and returns reverse geocode" do
      geocode =
        GraphqlAdapter.reverse_geocode(%{
          lat: 52.3730796,
          lon: 4.8924534
        })

      assert geocode.name == "Amsterdam"
    end
  end
end
