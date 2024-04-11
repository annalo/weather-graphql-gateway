defmodule WeatherGraphqlGateway.NominatimAPI.ClientTest do
  use ExUnit.Case

  alias WeatherGraphqlGateway.NominatimAPI.Client

  describe "Client.search/1" do
    test "searches for location query" do
      location_data = Client.search("Copenhagen")
      first = Enum.at(location_data, 0)

      assert first["name"] == "København"
    end
  end
end
