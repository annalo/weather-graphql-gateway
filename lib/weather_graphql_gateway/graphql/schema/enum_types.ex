defmodule WeatherGraphqlGateway.Graphql.Schema.EnumTypes do
  @moduledoc """
  This module defines GraphQL object types representing different weather data types.

  - `precipitation_unit`: Represents the units used for precipitation measurements. (:mm, :inch)
  - `temperature_unit`: Represents the units used for temperature measurements. (:celsius, :fahrenheit)
  - `wind_speed_unit`: Represents the units used for wind speed measurements. (:khm, :kh, :mph, :ms)

  """
  use Absinthe.Schema.Notation

  enum :precipitation_unit do
    description("The precipitation unit")
    value(:mm, description: "mm")
    value(:inch, description: "inch")
  end

  enum :temperature_unit do
    description("The temperature unit")
    value(:celsius, description: "Celsius")
    value(:fahrenheit, description: "Fahrenheit")
  end

  enum :wind_speed_unit do
    description("The wind speed unit")
    value(:kmh, description: "khm")
    value(:kn, description: "kn")
    value(:mph, description: "mph")
    value(:ms, description: "ms")
  end
end
