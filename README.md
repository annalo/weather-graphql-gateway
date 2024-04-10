# Weather GraphQL Gateway for Open-Meteo API

## Credit

This project utilizes the fantastic [Open-Meteo](https://open-meteo.com/) weather forecast API. A big thanks to their team for providing this valuable open-source resource!

## Description

This project implements a GraphQL gateway in Elixir using Phoenix and Absinthe. It seamlessly integrates the Open-Meteo weather API as a data source, providing a structured GraphQL interface.

### Features

- Leverages Elixir's concurrency and fault tolerance for a robust and scalable solution.
- Employs Phoenix for efficient web server handling and interaction.
- Utilizes Absinthe for defining and managing the GraphQL schema and resolvers.
- Offers a dedicated `OpenMeteoAPI` context for interacting with the weather API via an HTTP client.
- Includes a `GraphqlAdapter` and `GraphqlSerializer` within the OpenMeteoAPI context, bridging the gap between GraphQL and the HTTP API.
Usage:

### GraphQL Playground

Access the GraphQL playground directly at https://open-meteo-graphql.fly.dev to test your GraphQL queries visually.

### Example

```graphql
query {
  weather(latitude: 52.52, longitude: 13.41) {
    latitude
    longitude
    temperatureUnit
    current {
      temperature
    }
  }
}
```

### GraphQL Endpoint

You can query the GraphQL endpoint at https://open-meteo-graphql.fly.dev.
