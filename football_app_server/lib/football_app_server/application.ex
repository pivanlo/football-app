defmodule FootballAppServer.Application do
  @moduledoc false

  use Application
  require Logger

  def start(_type, _args) do
    port = String.to_integer(System.get_env("PORT") || "4000")

    Logger.info("Starting server in port #{port}...")

    children = [
      {Plug.Cowboy, scheme: :http, plug: FootballAppServer.Router, options: [port: port]},
      FootballAppServer.Repo,
      {Task.Supervisor, name: FootballAppServer.TaskSupervisor, strategy: :one_for_one}
    ]

    opts = [strategy: :one_for_one, name: FootballAppServer.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @doc """
  Starts the seeder under a Task.Supervisor. When done seeding, the
  seeder will stop the application and the entire system.
  """
  def start_seeder do
    Task.Supervisor.start_child(
      FootballAppServer.TaskSupervisor,
      fn ->
        FootballAppServer.Seeder.seed_database()
      end,
      restart: :transient
    )
  end
end
