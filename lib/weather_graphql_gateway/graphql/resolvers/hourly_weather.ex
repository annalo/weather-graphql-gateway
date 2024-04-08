defmodule WeatherGraphqlGateway.Graphql.Resolvers.HourlyWeather do
  alias WeatherGraphqlGateway.OpenMeteoApi.GraphqlAdapter

  @spec get_data(
          atom()
          | %{
              :latitude => number(),
              :longitude => number(),
              :precipitation_unit => binary(),
              :temperature_unit => binary(),
              :wind_speed_unit => binary(),
              optional(any()) => any()
            },
          %{:hours => integer()},
          any()
        ) :: nil
  def get_data(parent, %{hours: hours}, _resolution) do
    GraphqlAdapter.request_hourly_weather(
      parent.latitude,
      parent.longitude,
      parent.precipitation_unit,
      parent.temperature_unit,
      parent.wind_speed_unit,
      hours
    )
  end
end
