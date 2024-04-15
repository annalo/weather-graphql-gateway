defmodule WeatherGraphqlGateway.Graphql.Resolvers.ReverseGeocodeTest do
  use ExUnit.Case

  alias WeatherGraphqlGateway.Graphql.Resolvers.ReverseGeocode

  describe "ReverseGeocode.query" do
    test "returns the location from the reverse geocode" do
      {:ok, resolution} =
        ReverseGeocode.query(
          %{language: "en"},
          %{latitude: 52.3730796, longitude: 4.8924534},
          nil
        )

      assert resolution.name == "Amsterdam"
    end

    test "can query with language param" do
      {:ok, resolution} =
        ReverseGeocode.query(
          %{language: "zh-TW"},
          %{latitude: 25.0333448, longitude: 121.5668963},
          nil
        )

      assert resolution.name == "信義區"
    end
  end
end
