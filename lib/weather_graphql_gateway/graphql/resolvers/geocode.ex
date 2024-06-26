defmodule WeatherGraphqlGateway.Graphql.Resolvers.Geocode do
  @moduledoc """
  This module contains resolver function for querying geocode data in GraphQL queries.
  """

  @doc """
  The `get_data` resolver returns the parameters to the child resolvers.
  """
  @spec get_data(any(), %{language: String.t() | nil}, any()) :: %{}
  def get_data(_parent, args, _resolution) do
    case Map.has_key?(args, :language) do
      true -> {:ok, %{language: args.language}}
      false -> {:ok, %{language: nil}}
    end
  end
end
