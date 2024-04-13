defmodule WeatherGraphqlGateway.Graphql.Schema.LocationType do
  @moduledoc """
  This module defines a GraphQL object type representing a geographical location.

  A `location` object represents a specific place on Earth and provides various details
  for describing its position and identification.

  ## Fields

  - `boundingbox`: A list of floats representing the area defined by corner coordinates.
  - `display_name`: The full human-readable address of the location (string).
  - `lat`: The geographic latitude of the location's centroid in decimal degrees (float).
  - `lon`: The geographic longitude of the location's centroid in decimal degrees (float).
  - `name`: The name of the geographical feature (string).
  - `place_rank`: A search ranking provided by the geocoder (integer).
  """
  use Absinthe.Schema.Notation

  object :location do
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
