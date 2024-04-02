defmodule WeatherGraphqlGateway.OpenMeteoAPI.Models.DailyWeather do
  @moduledoc """
  Represents daily weather data returned by the Open Meteo API.
  """

  @derive {Poison.Encoder, only: []}

  defstruct []

  @type t :: %__MODULE__{

        }
end
