defmodule WeatherGraphqlGateway.OpenMeteoAPI.Models.CurrentWeather do
  @moduledoc """
  Represents current weather data returned by the Open Meteo API.
  """

  @derive {Poison.Encoder, only: []}

  defstruct []

  @type t :: %__MODULE__{

        }
end
