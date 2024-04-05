defmodule WeatherGraphqlGateway.MixProject do
  use Mix.Project

  def project do
    [
      app: :weather_graphql_gateway,
      version: "0.1.0",
      elixir: "~> 1.14",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),

      # Docs
      name: "MyApp",
      source_url: "https://github.com/annalo/weather-graphql-gateway",
      docs: [
        main: "readme", # The main page in the docs
        extras: extras(),
        groups_for_extras: groups_for_extras(),
        groups_for_modules: groups_for_modules()
      ]
    ]
  end

  # Configuration for the docs.
  defp extras do
    [
      "README.md"
    ]
  end

  defp groups_for_extras() do
    [
    ]
  end

  defp groups_for_modules do
    [
      GraphQL: [],
      "Open Meteo API": [
        WeatherGraphqlGateway.OpenMeteoAPI.Client,
        WeatherGraphqlGateway.OpenMeteoAPI.Models.WeatherRequest,
        WeatherGraphqlGateway.OpenMeteoAPI.Models.CurrentWeather,
        WeatherGraphqlGateway.OpenMeteoAPI.Models.HourlyWeather,
        WeatherGraphqlGateway.OpenMeteoAPI.Models.DailyWeather
      ]
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {WeatherGraphqlGateway.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:absinthe, "~> 1.7", override: true},
      {:absinthe_plug, "~> 1.5"},
      {:bandit, "~> 1.2"},
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false},
      {:dns_cluster, "~> 0.1.1"},
      {:ex_doc, "~> 0.31", only: :dev, runtime: false},
      {:gettext, "~> 0.20"},
      {:jason, "~> 1.2"},
      {:phoenix_live_dashboard, "~> 0.8.3"},
      {:phoenix, "~> 1.7.11"},
      {:plug_cowboy, "~> 2.0"},
      {:req, "~> 0.4.0"},
      {:swoosh, "~> 1.5"},
      {:telemetry_metrics, "~> 0.6"},
      {:telemetry_poller, "~> 1.0"}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      setup: ["deps.get"]
    ]
  end
end
