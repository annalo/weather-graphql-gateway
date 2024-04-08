defmodule WeatherGraphqlGateway.Graphql.Resolvers.DailyWeather do
  alias WeatherGraphqlGateway.OpenMeteoApi.GraphqlAdapter

  @spec get_data(
          atom()
          | %{
              :latitude => number(),
              :longitude => number(),
              :precipitation_unit => String.t(),
              :temperature_unit => String.t(),
              :wind_speed_unit => String.t()
            },
          %{:days => integer()},
          any()
        ) :: nil
  def get_data(parent, %{days: days}, _resolution) do
    GraphqlAdapter.request_daily_weather(
      parent.latitude,
      parent.longitude,
      parent.precipitation_unit,
      parent.temperature_unit,
      parent.wind_speed_unit,
      days
    )
  end
end
