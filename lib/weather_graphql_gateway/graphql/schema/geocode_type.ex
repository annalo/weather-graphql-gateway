defmodule WeatherGraphqlGateway.Graphql.Schema.GeocodeType do
  @moduledoc """
  This module defines GraphQL object types representing different geocoding types.
  """
  use Absinthe.Schema.Notation

  object :geocode do
    @desc "Area of corner coordinates."
    field(:boundingbox, list_of(:float))
    @desc "Full comma-separated address."
    field(:display_name, :string)
    @desc "Latitude of the centroid of the object."
    field(:lat, :float, name: "latitude")
    @desc "Longitude of the centroid of the object."
    field(:lon, :float, name: "longitude")
    @desc "Name of the place."
    field(:name, :string)
    @desc "Search rank of the object."
    field(:place_rank, :integer)
  end
end
