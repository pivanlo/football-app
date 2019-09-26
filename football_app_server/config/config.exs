use Mix.Config

config :football_app_server, FootballAppServer.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "football_app",
  hostname: "localhost",
  username: "postgres",
  password: "postgres"

config :football_app_server, ecto_repos: [FootballAppServer.Repo]
