defmodule WeatherGraphqlGateway.NominatimAPI.ClientTest do
  use ExUnit.Case

  alias WeatherGraphqlGateway.NominatimAPI.Client

  describe "Client.geocode/1" do
    test "returns list of geocodes from the query" do
      response = Client.geocode("Copenhagen")
      first = Enum.at(response, 0)

      assert first.boundingbox == [55.5267243, 55.8467243, 12.4100724, 12.7300724]

      assert first.display_name ==
               "København, Københavns Kommune, Region Hovedstaden, 1357, Danmark"

      assert first.lat == 55.6867243
      assert first.lon == 12.5700724
      assert first.name == "København"
      assert first.place_rank == 15
    end

    test "sets limit parameter" do
      response = Client.geocode("Copenhagen", %{limit: 2, language: nil})
      assert length(response) == 2
    end

    test "sets language parameter" do
      response = Client.geocode("Taipei", %{limit: 1, language: "zh-TW"})
      first = Enum.at(response, 0)

      assert first.display_name == "臺北市, 臺灣"
      assert first.name == "臺北市"
    end
  end

  describe "Client.reverse_geocode/1" do
    test "reverse geocoding" do
      response =
        Client.reverse_geocode(25.0330, 121.5654)

      assert response.boundingbox == [25.0081697, 25.0495075, 121.5526148, 121.5922279]
      assert response.display_name == "信義區, 臺北市, 臺灣"
      assert response.lat == 25.0333448
      assert response.lon == 121.5668963
      assert response.name == "信義區"
      assert response.place_rank == 14
    end

    test "sets language parameter" do
      response =
        Client.reverse_geocode(25.0330, 121.5654, "en")

      assert response.display_name == "Xinyi District, Taipei, Taiwan"
      assert response.name == "Xinyi District"
    end

    test "returns locale language if language is set to nil" do
      response =
        Client.reverse_geocode(25.0330, 121.5654, nil)

      assert response.display_name == "信義區, 臺北市, 臺灣"
      assert response.name == "信義區"
    end
  end
end
