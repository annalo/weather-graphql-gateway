defmodule WeatherGraphqlGateway.NominatimAPI.GraphqlAdapterTest do
  use ExUnit.Case

  alias WeatherGraphqlGateway.NominatimAPI.GraphqlAdapter

  describe "GraphqlAdapter.geocode/1" do
    test "queries and returns location results" do
      locations = GraphqlAdapter.geocode("Copenhagen")
      first = Enum.at(locations, 0)

      assert first.name == "København"
      assert first.latitude == 55.6867243
      assert first.longitude == 12.5700724
    end
  end

  describe "GraphqlAdapter.reverse_geocode/1" do
    test "queries and returns reverse geocode location" do
      location =
        GraphqlAdapter.reverse_geocode(%{
          lat: 52.3730796,
          lon: 4.8924534
        })

      assert location.name == "Amsterdam"
      assert location.address.country == "Nederland"
      assert location.address.state == "Noord-Holland"
    end
  end
end
