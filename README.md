# Weather and Geocoding GraphQL Gateway

## Credit

This project utilizes the fantastic:

- [Open-Meteo](https://open-meteo.com/) weather forecast API
- [Nominatim](https://nominatim.openstreetmap.org/) open-source geocoding service which uses OpenStreetMap data.

A big thanks to their teams for providing these valuable resources!

## Description

This project implements a GraphQL gateway in Elixir using Phoenix and Absinthe. It seamlessly integrates the Open-Meteo weather API and Nominatim geocoding service as data sources, providing a structured GraphQL interface.

### Features

- Leverages Elixir's concurrency and fault tolerance for a robust and scalable solution.
- Employs Phoenix for efficient web server handling and interaction.
- Utilizes Absinthe for defining and managing the GraphQL schema and resolvers.
- Offers dedicated contexts for interacting with each API:
    - `OpenMeteoAPI` context for weather data retrieval.
    - `NominatimAPI` context for geocoding and reverse geocoding functionalities.
- Both contexts utilize HTTP clients for communication with their respective APIs.
- `GraphqlAdapter` and `GraphqlSerializer` components within each context bridge the gap between GraphQL and the APIs (data fetching and serialization).

### GraphQL Playground

Access the GraphQL playground at https://geocode-weather-graphql.fly.dev to test your GraphQL queries visually.

### Example

```graphql
query {
  # Weather data using latitude and longitude (OpenMeteoAPI)
  weather(latitude: 52.52, longitude: 13.41) {
    latitude
    longitude
    temperatureUnit
    current {
      temperature
    }
  }

  # Geocoding - query search to coordinates
  geocode(address: "Taipei") {
    latitude
    longitude
  }

  # Reverse geocoding - coordinates to location
  reverseGeocode(latitude: 37.7749, longitude: -122.4194) {
    address
  }
}
```

### GraphQL Endpoint

You can query the GraphQL endpoint at https://geocode-weather-graphql.fly.dev.
