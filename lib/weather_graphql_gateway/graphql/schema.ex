defmodule WeatherGraphqlGateway.Graphql.Schema do
  @moduledoc """
  This module defines the GraphQL schema for fetching weather data.

  The schema provides queries for retrieving current, hourly, and daily weather data.

  ## Enums
  - `:precipitation_unit`: Enum representing units for precipitation (mm, inch).
  - `:temperature_unit`: Enum representing units for temperature (Celsius, Fahrenheit).
  - `:wind_speed_unit`: Enum representing units for wind speed (km/h, m/s, mph, kn).

  ## Objects
    - `:current`: Current weather data.
    - `:daily`: Daily weather data.
    - `:hourly`: Hourly weather data.
  - `:weather`: Weather data.

  ## Queries
  - `weather`: Query for retrieving weather data.

  #### Arguments
    - `latitude`
    - `longitude`
    - `precipitation_unit` (optional)
    - `temperature_unit` (optional)
    - `wind_speed_unit` (optional)
  """
  use Absinthe.Schema

  import_types Absinthe.Type.Custom
  import_types WeatherGraphqlGateway.Graphql.Schema.WeatherTypes

  enum :precipitation_unit do
    description "The precipitation unit"
    value :mm, description: "mm"
    value :inch, description: "inch"
  end

  enum :temperature_unit do
    description "The temperature unit"
    value :celsius, description: "Celsius"
    value :fahrenheit, description: "Fahrenheit"
  end

  enum :wind_speed_unit do
    description "The wind speed unit"
    value :kmh, description: "khm"
    value :kn, description: "kn"
    value :mph, description: "mph"
    value :ms, description: "ms"
  end

  object :weather do
    @desc "Current weather data."
    field :current, :current
    @desc "Daily weather data. Defaults to 7 days."
    field :daily, list_of(:daily) do
      @desc "Per default, only 7 days are returned. Up to 16 days of forecast are possible."
      arg :days, :integer
    end
    @desc "Hourly data. Defaults to the next 24h."
    field :hourly, list_of(:hourly) do
      @desc "Per default, the next 24 hours are returned. Up to 16 days of forecast are possible."
      arg :hours, :integer
    end
  end

  query do
    @desc "Weather data"
    field :weather, :weather do
      arg :latitude, non_null(:float)
      arg :longitude, non_null(:float)
      @desc "The unit of measurement for precipitation. Defaults to mm. (mm/inch)"
      arg :precipitation_unit, :precipitation_unit
      @desc "The unit of measurement for temperature. Defaults to Celsius. (celsius/fahrenheit)"
      arg :temperature_unit, :temperature_unit
      @desc "The unit of measurement for wind speed. Defaults to kmh. (kmh, ms, mph, kn)"
      arg :wind_speed_unit, :wind_speed_unit
    end
  end
end
