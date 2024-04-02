defmodule WeatherGraphqlGateway.OpenMeteoAPI.Models.Weather do
  @moduledoc """
  Represents weather data returned by the Open Meteo API.
  """

  @derive {Poison.Encoder, only: [
    :temperature,
    :humidity,
    :wind_speed
  ]}

  defstruct [
    :temperature,
    :humidity,
    :wind_speed
  ]

  @type t :: %__MODULE__{
          temperature: number(),
          humidity: number(),
          wind_speed: number()
        }
end
