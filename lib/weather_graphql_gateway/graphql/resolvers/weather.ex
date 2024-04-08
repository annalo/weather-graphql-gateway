defmodule WeatherGraphqlGateway.Graphql.Resolvers.Weather do
  @spec get_data(
          any(),
          %{
            :latitude => number(),
            :longitude => number(),
            :precipitation_unit => String.t(),
            :temperature_unit => String.t(),
            :wind_speed_unit => String.t()
          },
          any()
        ) :: %{
          latitude: number(),
          longitude: number(),
          precipitation_unit: String.t(),
          temperature_unit: String.t(),
          wind_speed_unit: String.t()
        }
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
