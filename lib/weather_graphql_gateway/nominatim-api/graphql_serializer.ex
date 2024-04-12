defmodule WeatherGraphqlGateway.NominatimAPI.GraphqlSerializer do
  @doc """
  Converts nested map keys to atoms.
  """
  @spec atomize_keys(any()) :: any()
  def atomize_keys(map) when is_map(map) do
    for {key, value} <- map, into: %{} do
      {String.to_atom(key), atomize_keys(value)}
    end
  end

  def atomize_keys(value), do: value

  @doc """
  Serializes geocode data retrieved from the Nominatim API query.

  This function takes a list of geocode data, atomize the keys,
  and convert latitude and longitude from string to float.
  """
  @spec serialize_geocode_data(list(map())) ::
          list(%{
            :name => String.t(),
            :display_name => String.t(),
            :latitude => number(),
            :longitude => number(),
            :category => String.t(),
            :type => String.t()
          })
  def serialize_geocode_data(response) do
    response |> Enum.map(&serialize_geocode_location/1)
  end

  defp serialize_geocode_location(location) do
    %{
      name: location["name"],
      display_name: location["display_name"],
      latitude: location["lat"] |> String.to_float(),
      longitude: location["lon"] |> String.to_float(),
      category: location["category"],
      type: location["type"]
    }
  end
end
