defmodule FootballAppServer.Match do
  use Ecto.Schema

  schema "matches" do
    field(:div, :string)
    field(:season, :string)
    field(:date, :date)
    field(:home_team, :string)
    field(:away_team, :string)
    field(:fthg, :integer)
    field(:ftag, :integer)
    field(:ftr, :string)
    field(:hthg, :integer)
    field(:htag, :integer)
    field(:htr, :string)
  end
end
