defmodule WeatherGraphqlGateway.Graphql.Resolvers.HourlyWeather do
  def get_data(_parent, %{hours: _hours}, _resolution) do
    # request hourly weather data
  end
end
