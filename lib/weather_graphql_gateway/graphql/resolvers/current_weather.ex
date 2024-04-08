defmodule WeatherGraphqlGateway.Graphql.Resolvers.CurrentWeather do
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
          any(),
          any()
        ) :: nil
  def get_data(parent, _args, _resolution) do
    GraphqlAdapter.request_current_weather(
      parent.latitude,
      parent.longitude,
      parent.precipitation_unit,
      parent.temperature_unit,
      parent.wind_speed_unit
    )
  end
end
