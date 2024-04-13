defmodule WeatherGraphqlGateway.NominatimAPI.Models.Geocode do
  @moduledoc """
  Represents geocode data return by the [Nominatim Geocode API](https://nominatim.org/release-docs/latest/api/Output/) in the JSONv2 format.

  This module provides a structured representation of geocode data returned by the Nominatim Geocode API.

   ## Fields

    - `boundingbox`: Area of corner coordinates.
    - `display_name`: Full comma-separated address.
    - `lat`: Latitude of the centroid of the object.
    - `lon`: Longitude of the centroid of the object.
    - `name`: Name of the place.
    - `place_rank`: Search rank of the object
  """
  @enforce_keys [
    :boundingbox,
    :display_name,
    :lat,
    :lon,
    :name,
    :place_rank
  ]
  @type t :: %__MODULE__{
          boundingbox: [number()],
          display_name: String.t(),
          lat: number(),
          lon: number(),
          name: String.t(),
          place_rank: integer()
        }

  defstruct [
    :boundingbox,
    :display_name,
    :lat,
    :lon,
    :name,
    :place_rank
  ]
end
