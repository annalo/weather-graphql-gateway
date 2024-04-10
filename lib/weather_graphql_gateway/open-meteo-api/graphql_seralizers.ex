defmodule WeatherGraphqlGateway.OpenMeteoApi.GraphqlSerializer do
  def atomize(map) do
    map
    |> Map.new(fn {k, v} -> {String.to_atom(k), v} end)
  end

  def serialize_daily_weather(%{
    precipitation_probability_max: precipitation_probability_max,
    sunrise: sunrise,
    sunset: sunset,
    temperature_2m_max: temperature_2m_max,
    temperature_2m_min: temperature_2m_min,
    time: time,
    weather_code: weather_code
  }) do
    for index <- 0..(length(time) - 1) do
      %{
        precipitation_probability_max: Enum.at(precipitation_probability_max, index),
        sunrise: Enum.at(sunrise, index),
        sunset: Enum.at(sunset, index),
        temperature_2m_max: Enum.at(temperature_2m_max, index),
        temperature_2m_min: Enum.at(temperature_2m_min, index),
        time: Enum.at(time, index),
        weather_code: Enum.at(weather_code, index)
      }
    end
  end

  def serialize_hourly_weather(%{
    is_day: is_day,
    precipitation_probability: precipitation_probability,
    temperature_2m: temperature_2m,
    time: time,
    weather_code: weather_code
  }) do
    for index <- 0..(length(is_day) - 1) do
      %{
        is_day: Enum.at(is_day, index),
        precipitation_probability: Enum.at(precipitation_probability, index),
        temperature_2m: Enum.at(temperature_2m, index),
        time: Enum.at(time, index),
        weather_code: Enum.at(weather_code, index)
      }
    end
  end
end
