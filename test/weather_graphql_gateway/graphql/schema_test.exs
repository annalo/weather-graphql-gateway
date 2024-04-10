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

  test "query: weather", %{conn: conn} do
    conn =
      post(conn, "/api", %{
        "query" => @weather_query,
        "variables" => %{
          latitude: 35.7279,
          longitude: -78.85654,
          daily_forecast_days: 5,
          hourly_forecast_days: 2
        }
      })

    response = json_response(conn, 200)
    weather_data = response["data"]["weather"]

    assert weather_data["latitude"] == 35.7279
    assert weather_data["longitude"] == -78.85654
    assert weather_data["precipitationUnit"] == "inch"
    assert weather_data["temperatureUnit"] == "fahrenheit"
    assert weather_data["windSpeedUnit"] == "mph"

    assert weather_data["current"]["apparentTemperature"] |> is_number == true
    assert weather_data["daily"] |> length() == 5
    assert weather_data["hourly"] |> length() == 48
  end
end
