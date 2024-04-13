defmodule WeatherGraphqlGateway.Graphql.Schema do
  @moduledoc """
  This module defines the GraphQL schema for fetching geographic location (geocode) and weather data.

  The schema provides the following queries:

  * **geocode**: Retrieves location information for a given search term.
  * **weather**: Retrieves weather data for a specified latitude and longitude.

  ## Geocode Query

  The `geocode` query searches for locations based on a text input and provides various options to customize the results.

  ### Arguments

  * `search` (**required**, `string`): The text to search for locations.
  * `limit` (optional, `integer`, defaults to `10`): The maximum number of locations to return (capped at 40).
  * `language` (optional, `string`, defaults to `"en"`): The preferred language(s) for search results, comma-separated (e.g., `"en,de"`).

  ## Reverse Geocode Query

  The `reverse` field within the `geocode` object allows you to retrieve location information for a given pair of latitude and longitude coordinates.

  ### Arguments

  * `latitude` (**required**, `float`): The latitude coordinate.
  * `longitude` (**required**, `float`): The longitude coordinate.

  ## Weather Query

  The `weather` query retrieves weather data for a specific location specified by latitude and longitude. It also allows you to customize the units used for various weather measurements.

  ### Arguments

  * `latitude` (**required**, `float`): The latitude coordinate.
  * `longitude` (**required**, `float`): The longitude coordinate.
  * `precipitation_unit` (optional, `precipitation_unit`, defaults to `"inch"`): The desired unit for precipitation (options: `"mm"`, `"inch"`).
  * `temperature_unit` (optional, `temperature_unit`, defaults to `"fahrenheit"`): The desired unit for temperature (options: `"celsius"`, `"fahrenheit"`).
  * `wind_speed_unit` (optional, `wind_speed_unit`, defaults to `"mph"`): The desired unit for wind speed (options: `"kmh"`, `"ms"`, `"mph"`, `"kn"`).

  ## Data Sources

  * **Geocode**: Nominatim (https://nominatim.openstreetmap.org)
  * **Weather**: Open Meteo API (https://open-meteo.com/en/docs)
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
    @desc "Geocode/Reverse Geocode source: Nominatim (https://nominatim.openstreetmap.org) (search engine for OpenStreetMap data)"
    field :geocode, :geocode do
      @desc "Preferred language order for showing search results. This may either be a simple comma-separated list of language codes. Defaults to 'en'."
      arg(:language, :string, default_value: "en")
      resolve(&Resolvers.Geocode.get_data/3)
    end

    @desc "Weather source: Open Meteo API (https://open-meteo.com/en/docs)"
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
