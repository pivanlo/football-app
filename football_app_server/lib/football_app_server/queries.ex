defmodule FootballAppServer.Queries do
  import Ecto.Query

  alias FootballAppServer.Match
  alias FootballAppServer.Repo

  @doc """
  Queries the database for the division and season pairs.
  """
  def get_leagues do
    Repo.all(
      from(m in Match,
        group_by: [m.div, m.season],
        select: map(m, [:div, :season])
      )
    )
  end

  @doc """
  Queries the database for the matches for a specific division and season pair.
  """
  def get_matches(division, season) do
    Repo.all(
      from(m in Match,
        where: m.div == ^division and m.season == ^season,
        select: m
      )
    )
    |> Enum.map(&Map.from_struct(&1))
    |> Enum.map(&Map.delete(&1, :__meta__))
  end
end
