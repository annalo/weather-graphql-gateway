defmodule WeatherGraphqlGateway.NominatimAPI.GraphqlSerializer do
  def serialize_geocode_data(response) do
    response |> Enum.map(&atomize_geocode_location/1)
  end


  def atomize_keys(map) when is_map(map) do
    for {key, value} <- map, into: %{} do
      {String.to_atom(key), atomize_keys(value)}
    end
  end

  def atomize_keys(value), do: value

  defp atomize_geocode_location(location) do
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
