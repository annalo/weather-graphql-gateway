defmodule WeatherGraphqlGateway.NominatimAPI.ClientTest do
  use ExUnit.Case

  alias WeatherGraphqlGateway.NominatimAPI.Client

  describe "Client.geocode/1" do
    test "provide coordinates corresponding to a location" do
      response = Client.geocode("Copenhagen")
      first = Enum.at(response, 0)

      assert first.boundingbox == [55.5267243, 55.8467243, 12.4100724, 12.7300724]

      assert first.display_name ==
               "Copenhagen, Copenhagen Municipality, Capital Region of Denmark, 1357, Denmark"

      assert first.lat == 55.6867243
      assert first.lon == 12.5700724
      assert first.name == "Copenhagen"
      assert first.place_rank == 15
    end
  end

  describe "Client.reverse_geocode/1" do
    test "reverse geocoding" do
      response =
        Client.reverse_geocode(%{
          lat: 25.0330,
          lon: 121.5654
        })

      assert response.boundingbox == [25.0081697, 25.0495075, 121.5526148, 121.5922279]
      assert response.display_name == "Xinyi District, Taipei, Taiwan"
      assert response.lat == 25.0333448
      assert response.lon == 121.5668963
      assert response.name == "Xinyi District"
      assert response.place_rank == 14
    end
  end
end
