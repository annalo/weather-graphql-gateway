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

  ### Arguments
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
  import_types(WeatherGraphqlGateway.Graphql.Schema.LocationType)
  import_types(WeatherGraphqlGateway.Graphql.Schema.WeatherTypes)

  object :geocode do
    field :search, list_of(:location) do
      @desc "The address query."
      arg(:query, non_null(:string))
      @desc "Limit the maximum number of returned results. Cannot be more than 40. Defaults to 10"
      arg(:limit, :integer, default_value: 10)

      @desc "Preferred language order for showing search results. This may either be a simple comma-separated list of language codes. Defaults to 'en'."
      arg(:language, :string, default_value: "en")

      resolve(&Resolvers.GeocodeSearch.query/3)
    end

    field :reverse, :location do
      @desc "The latitude of the coordinates to reverse geocode"
      arg(:latitude, non_null(:float))
      @desc "The longitude of the coordinates to reverse geocode"
      arg(:longitude, non_null(:float))

      resolve(&Resolvers.ReverseGeocode.query/3)
    end
  end

  query do
    @desc "Geocode"
    field :geocode, :geocode do
      resolve(&Resolvers.Geocode.get_data/3)
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
