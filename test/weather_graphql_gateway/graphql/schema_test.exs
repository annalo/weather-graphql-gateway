defmodule WeatherGraphqlGateway.Graphql.SchemaTest do
  use WeatherGraphqlGatewayWeb.ConnCase

  @weather_query """
  query getWeather(
    $latitude: Float!
    $longitude: Float!
    $daily_forecast_days: Int
    $hourly_forecast_days: Int
  ) {
    weather(
      latitude: $latitude
      longitude: $longitude
    ) {
      latitude
      longitude
      precipitationUnit
      temperatureUnit
      windSpeedUnit
      current {
        apparentTemperature
      }
      daily(forecastDays: $daily_forecast_days) {
        temperatureMax
        temperatureMin
      }
      hourly(forecastDays: $hourly_forecast_days) {
        weatherCode
      }
    }
  }
  """

  @geocode_query """
  query geocode($query: String!) {
    geocode(query: $query) {
      name
      latitude
      longitude
    }
  }
  """

  test "query weather", %{conn: conn} do
    conn =
      post(conn, "/", %{
        "query" => @weather_query,
        "variables" => %{
          latitude: 25.0340,
          longitude: 121.5645,
          daily_forecast_days: 5,
          hourly_forecast_days: 2
        }
      })

    response = json_response(conn, 200)
    weather_data = response["data"]["weather"]

    assert weather_data["latitude"] == 25.0340
    assert weather_data["longitude"] == 121.5645
    assert weather_data["precipitationUnit"] == "inch"
    assert weather_data["temperatureUnit"] == "fahrenheit"
    assert weather_data["windSpeedUnit"] == "mph"

    assert weather_data["current"]["apparentTemperature"] |> is_number == true
    assert weather_data["daily"] |> length() == 5
    assert weather_data["hourly"] |> length() == 48
  end

  test "query geocode", %{conn: conn} do
    conn =
      post(conn, "/", %{
        "query" => @geocode_query,
        "variables" => %{
          query: "Taipei"
        }
      })

    response = json_response(conn, 200)
    geocode_data = response["data"]["geocode"]
    first = Enum.at(geocode_data, 0)

    assert first["name"] == "Taipei"
  end
end
