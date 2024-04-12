defmodule WeatherGraphqlGateway.Graphql.Resolvers.ReverseGeocodeTest do
  use ExUnit.Case

  alias WeatherGraphqlGateway.Graphql.Resolvers.ReverseGeocode

  describe "ReverseGeocode.query" do
    test "returns the location from the reverse geocode" do
      {:ok, resolution} =
        ReverseGeocode.query(
          nil,
          %{latitude: 52.3730796, longitude: 4.8924534},
          nil
        )

      assert resolution.name == "Centrum"
      assert resolution.address.country == "Netherlands"
    end
  end
end
