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
    - `precipitation_unit`
    - `temperature_unit`
    - `wind_speed_unit`
  """
  use Absinthe.Schema
  alias WeatherGraphqlGateway.Graphql.Resolvers

  import_types(Absinthe.Type.Custom)
  import_types(WeatherGraphqlGateway.Graphql.Schema.EnumTypes)
  import_types(WeatherGraphqlGateway.Graphql.Schema.GeocodeTypes)
  import_types(WeatherGraphqlGateway.Graphql.Schema.WeatherTypes)

  # weather
  object :weather do
    field(:latitude, :float)
    field(:longitude, :float)
    field(:precipitation_unit, :string)
    field(:temperature_unit, :string)
    field(:wind_speed_unit, :string)
    @desc "Current weather data."
    field :current, :current do
      resolve(&Resolvers.CurrentWeather.get_data/3)
    end

    @desc "Daily weather data. Defaults to 7 days."
    field :daily, list_of(:daily) do
      @desc "Per default, only 7 days are returned. Up to 16 days of forecast are possible."
      arg(:forecast_days, :integer, default_value: 7)
      resolve(&Resolvers.DailyWeather.get_data/3)
    end

    @desc "Hourly data. Defaults to today's 24h."
    field :hourly, list_of(:hourly) do
      @desc "Per default, today's 24h is returned. Up to 16 days of forecast are possible."
      arg(:forecast_days, :integer, default_value: 1)
      resolve(&Resolvers.HourlyWeather.get_data/3)
    end
  end

  query do
    @desc "Geocode"
    field :geocode, list_of(:location) do
      arg(:query, non_null(:string))
      resolve(&Resolvers.Geocode.query/3)
    end

    @desc "Reverse geocode"
    field :reverse_geocode, :reverse_geocode do
      arg(:latitude, non_null(:float))
      arg(:longitude, non_null(:float))
      resolve(&Resolvers.ReverseGeocode.query/3)
    end

    @desc "Weather data"
    field :weather, :weather do
      arg(:latitude, non_null(:float))
      arg(:longitude, non_null(:float))
      @desc "The unit of measurement for precipitation. Defaults to inch. (mm/inch)"
      arg(:precipitation_unit, :precipitation_unit, default_value: :inch)

      @desc "The unit of measurement for temperature. Defaults to Fahrenheit. (celsius/fahrenheit)"
      arg(:temperature_unit, :temperature_unit, default_value: :fahrenheit)
      @desc "The unit of measurement for wind speed. Defaults to mph. (kmh, ms, mph, kn)"
      arg(:wind_speed_unit, :wind_speed_unit, default_value: :mph)

      resolve(&Resolvers.Weather.get_data/3)
    end
  end
end
