defmodule WeatherGraphqlGateway.Graphql.Resolvers.Weather do
  def get_data(
    _parent,
    %{
      latitude: latitude,
      longitude: longitude,
      precipitation_unit: precipitation_unit,
      temperature_unit: temperature_unit,
      wind_speed_unit: wind_speed_unit
    },
    _resolution) do
      %{
        latitude: latitude,
        longitude: longitude,
        precipitation_unit: precipitation_unit,
        temperature_unit: temperature_unit,
        wind_speed_unit: wind_speed_unit
      }
  end
end
