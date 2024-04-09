defmodule WeatherGraphqlGateway.Graphql.Resolvers.Weather do
  @moduledoc """
  This module contains resolver function for fetching weather data in GraphQL queries.
  """

  @doc """
  The `get_data` resolver returns the parameters to the child resolvers.
  """
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
  def get_data(_parent,
    %{
      latitude: latitude,
      longitude: longitude,
      precipitation_unit: precipitation_unit,
      temperature_unit: temperature_unit,
      wind_speed_unit: wind_speed_unit
    },
    _resolution) do
      {
        :ok,
        %{
          latitude: latitude,
          longitude: longitude,
          precipitation_unit: precipitation_unit,
          temperature_unit: temperature_unit,
          wind_speed_unit: wind_speed_unit
        }
      }
  end
end
