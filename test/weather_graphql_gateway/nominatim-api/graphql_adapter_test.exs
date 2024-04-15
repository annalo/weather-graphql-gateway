defmodule WeatherGraphqlGateway.NominatimAPI.GraphqlAdapterTest do
  use ExUnit.Case
  require Logger
  alias WeatherGraphqlGateway.NominatimAPI.GraphqlAdapter

  describe "GraphqlAdapter.geocode/1" do
    test "queries and returns geocode results" do
      geocodes =
        GraphqlAdapter.geocode("Copenhagen", %{
          language: "en",
          limit: 1
        })

      first = Enum.at(geocodes, 0)

      assert first.boundingbox == [55.5267243, 55.8467243, 12.4100724, 12.7300724]

      assert first.display_name ==
               "Copenhagen, Copenhagen Municipality, Capital Region of Denmark, 1357, Denmark"

      assert first.lat == 55.6867243
      assert first.lon == 12.5700724
      assert first.name == "Copenhagen"
      assert first.place_rank == 15
    end

    test "does not set limit and language parameter" do
      geocodes =
        GraphqlAdapter.geocode("Xinyi", %{
          limit: nil,
          language: nil
        })

      first = Enum.at(geocodes, 0)
      # Nominatim defaults the limit to 10
      assert length(geocodes) == 10
      # if no language provided, returns locale language
      assert first.name == "信宜市"
    end
  end

  describe "GraphqlAdapter.reverse_geocode/1" do
    test "queries and returns reverse geocode" do
      geocode =
        GraphqlAdapter.reverse_geocode(52.3730796, 4.8924534)

      assert geocode.name == "Amsterdam"
    end

    test "sets language parameter" do
      geocode =
        GraphqlAdapter.reverse_geocode(55.6867243, 12.5700724, "zh-TW")

      assert geocode.name == "哥本哈根"
    end
  end
end
