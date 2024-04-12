defmodule WeatherGraphqlGateway.Graphql.Schema.GeocodeTypes do
  @moduledoc """
  This module defines GraphQL object types representing different geocoding types.
  """
  use Absinthe.Schema.Notation

  object :location do
    field(:category, :string)
    field(:display_name, :string)
    field(:latitude, :float)
    field(:longitude, :float)
    field(:name, :string)
    field(:type, :string)
  end

  object :reverse_geocode do
    field(:address, :address)
    field(:display_name, :string)
    field(:name, :string)
  end

  object :address do
    field(:city, :string)
    field(:country, :string)
    field(:country_code, :string)
    field(:state, :string)
  end
end
