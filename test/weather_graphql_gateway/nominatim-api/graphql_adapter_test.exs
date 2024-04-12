defmodule WeatherGraphqlGateway.NominatimAPI.GraphqlAdapterTest do
  use ExUnit.Case

  alias WeatherGraphqlGateway.NominatimAPI.GraphqlAdapter

  describe "GraphqlAdapter.geocode/1" do
    test "queries and returns location results" do
      locations = GraphqlAdapter.geocode("Copenhagen")
      first = Enum.at(locations, 0)

      assert first.name == "Copenhagen"
      assert first.latitude == 55.6867243
      assert first.longitude == 12.5700724
    end
  end

  describe "GraphqlAdapter.reverse_geocode/1" do
    test "queries and returns reverse geocode location" do
      location =
        GraphqlAdapter.reverse_geocode(%{
          latitude: 52.3730796,
          longitude: 4.8924534
        })

      assert location.name == "Centrum"
      assert location.address.country == "Netherlands"
      assert location.address.state == "North Holland"
    end
  end
end
