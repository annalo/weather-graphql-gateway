defmodule WeatherGraphqlGateway.Graphql.Schema.GeocodeTypes do
  @moduledoc """
  This module defines GraphQL object types representing different geocoding types.
  """
  use Absinthe.Schema.Notation

  object :location do
    field(:name, :string)
    field(:display_name, :string)
    field(:latitude, :float)
    field(:longitude, :float)
    field(:category, :string)
    field(:type, :string)
  end

  object :reverse do
    field(:name, :string)
    field(:address, :address)
  end

  object :address do
    field(:state, :string)
    field(:country, :string)
  end
end
