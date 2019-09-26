defmodule FootballAppServer.Repo do
  use Ecto.Repo, otp_app: :football_app_server

  def init(_, opts) do
    {:ok, build_opts(opts)}
  end

  defp build_opts(opts) do
    system_opts = [
      database: System.get_env("FOOTBALL_APP_DB"),
      hostname: System.get_env("FOOTBALL_APP_DB_HOSTNAME"),
      username: System.get_env("FOOTBALL_APP_DB_USERNAME"),
      password: System.get_env("FOOTBALL_APP_DB_PASSWORD")
    ]

    Keyword.merge(opts, system_opts)
  end
end
