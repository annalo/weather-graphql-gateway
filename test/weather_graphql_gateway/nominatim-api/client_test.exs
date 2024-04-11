defmodule WeatherGraphqlGateway.NominatimAPI.ClientTest do
  use ExUnit.Case

  alias WeatherGraphqlGateway.NominatimAPI.Client

  describe "Client.search/1" do
    test "provide coordinates corresponding to a location" do
      response = Client.search("Copenhagen")
      first = Enum.at(response, 0)

      assert first["name"] == "København"
      assert first["lat"] == "55.6867243"
      assert first["lon"] == "12.5700724"
    end
  end

  describe "Client.reverse/1" do
    test "reverse geocoding" do
      response = Client.reverse(%{lat: 35.8317, lon: -78.9286})
      address = response["address"]

      assert address["city"] == "Cary"
      assert address["state"] == "North Carolina"
    end
  end
end