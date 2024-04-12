defmodule WeatherGraphqlGateway.OpenMeteoAPI.GraphqlSerializer do
  @moduledoc """
  Provides functions to serialize weather data received from OpenMeteoAPI responses.

  This module offers functionalities to transform weather data obtained from the OpenMeteoAPI into a format suitable for GraphQL responses. It includes functions to:
    - Convert map keys to atoms (`atomize/1`)
    - Serialize daily weather data (`serialize_daily_weather/1`)
    - Serialize hourly weather data (`serialize_hourly_weather/1`)

  """

  @doc """
  Converts map keys to atoms.
  """
  @spec atomize_keys(map()) :: map()
  def atomize_keys(map) do
    map
    |> Map.new(fn {k, v} -> {String.to_atom(k), v} end)
  end

  @doc """
  Serializes daily weather data into a list of maps.

  This function takes a map containing daily weather data and transforms it into a list of maps, where each inner map represents the weather for a single day.
  """
  @spec serialize_daily_weather(%{
          :precipitation_probability_max => integer(),
          :sunrise => String.t(),
          :sunset => String.t(),
          :temperature_2m_max => number(),
          :temperature_2m_min => number(),
          :time => list(String.t()),
          :weather_code => integer()
        }) :: list(%{})
  def serialize_daily_weather(%{
        precipitation_probability_max: precipitation_probability_max,
        sunrise: sunrise,
        sunset: sunset,
        temperature_2m_max: temperature_2m_max,
        temperature_2m_min: temperature_2m_min,
        time: time,
        weather_code: weather_code
      }) do
    for index <- 0..(length(time) - 1) do
      %{
        precipitation_probability_max: Enum.at(precipitation_probability_max, index),
        sunrise: Enum.at(sunrise, index),
        sunset: Enum.at(sunset, index),
        temperature_2m_max: Enum.at(temperature_2m_max, index),
        temperature_2m_min: Enum.at(temperature_2m_min, index),
        time: Enum.at(time, index),
        weather_code: Enum.at(weather_code, index)
      }
    end
  end

  @doc """
  Serializes hourly weather data into a list of maps.

  This function takes a map containing hourly weather data and transforms it into a list of maps, where each inner map represents the weather for a single hour.
  """
  @spec serialize_hourly_weather(%{
          :is_day => integer(),
          :precipitation_probability => integer(),
          :temperature_2m => number(),
          :time => String.t(),
          :weather_code => integer()
        }) :: list(%{})
  def serialize_hourly_weather(%{
        is_day: is_day,
        precipitation_probability: precipitation_probability,
        temperature_2m: temperature_2m,
        time: time,
        weather_code: weather_code
      }) do
    for index <- 0..(length(is_day) - 1) do
      %{
        is_day: Enum.at(is_day, index),
        precipitation_probability: Enum.at(precipitation_probability, index),
        temperature_2m: Enum.at(temperature_2m, index),
        time: Enum.at(time, index),
        weather_code: Enum.at(weather_code, index)
      }
    end
  end
end
