defmodule WeatherGraphqlGateway.OpenMeteoAPI.Models.HourlyWeather do
  @moduledoc """
  Represents hourly weather data returned by the Open Meteo API.
  """

  @derive {Poison.Encoder, only: []}

  defstruct []

  @type t :: %__MODULE__{

        }
end
