defmodule WeatherGraphqlGateway.Graphql.Resolvers.Geocode do
  @moduledoc """
  This module contains resolver function for querying geocode data in GraphQL queries.
  """

  @doc """
  The `get_data` resolver returns the parameters to the child resolvers.
  """
  @spec get_data(any(), %{}, any()) :: %{}
  def get_data(_parent, _variables, _resolution), do: {:ok, %{}}
end
