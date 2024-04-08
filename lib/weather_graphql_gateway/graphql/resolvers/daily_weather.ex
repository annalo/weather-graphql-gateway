defmodule WeatherGraphqlGateway.Graphql.Resolvers.DailyWeather do
  def get_data(_parent, %{days: _days}, _resolution) do
    # request daily weather data
  end
end
