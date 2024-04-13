defmodule WeatherGraphqlGateway.Graphql.Schema.GeocodeTypes do
  @moduledoc """
  This module defines GraphQL object types representing different geocoding types.
  """
  use Absinthe.Schema.Notation

  object :location do
    field(:category, :string)
    field(:display_name, :string)
    field(:lat, :float, name: "latitude")
    field(:lon, :float, name: "longitude")
    field(:name, :string)
    field(:type, :string)
  end

  object :reverse_geocode do
    field(:display_name, :string)
    field(:name, :string)
  end
end
