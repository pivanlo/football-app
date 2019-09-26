defmodule FootballAppServer.Repo.Migrations.CreateMatches do
  use Ecto.Migration

  def change do
    create table(:matches) do
    	add :div, :string
      add :season, :string
      add :date, :date
      add :home_team, :string
      add :away_team, :string
      add :fthg, :integer
      add :ftag, :integer
      add :ftr, :string
      add :hthg, :integer
      add :htag, :integer
      add :htr, :string
    end

    create index(:matches, [:div, :season])
  end
end
