defmodule FootballAppServer.Seeder do
  @moduledoc """
  This module read the 'Data.csv' file and seeds
  the 'matches' database table.
  """

  @doc """
  Seeds the database using the 'Data.csv' file.
  """
  def seed_database do
    IO.puts("Waiting for database to be ready...")

    # Wait for database to be ready for seeding.
    Process.sleep(2000)

    # Create the database.
    IO.puts("Creating the database...")
    System.cmd("mix", ["ecto.create"])

    # Migrate the database.
    IO.puts("Migrating the database...")
    System.cmd("mix", ["ecto.migrate"])

    # Delete all the Match records in the database.
    IO.puts("Deleting records...")
    FootballAppServer.Repo.delete_all(FootballAppServer.Match)

    # Read the csv file,format the data and insert it in the database.
    IO.puts("Seeding database...")

    File.stream!("priv/Data.csv")
    |> CSV.decode!(headers: true)
    |> Enum.map(fn x -> format_match_record(x) end)
    |> (&FootballAppServer.Repo.insert_all(FootballAppServer.Match, &1)).()

    # Stop the application and the entire sytem.
    :init.stop()
  end

  @doc """
  Formats the Match records according to the FootballAppServer.Match schema.
  """
  def format_match_record(record) do
    [
      div: record["Div"],
      season: record["Season"],
      date: to_date(record["Date"]),
      home_team: record["HomeTeam"],
      away_team: record["AwayTeam"],
      fthg: String.to_integer(record["FTHG"]),
      ftag: String.to_integer(record["FTAG"]),
      ftr: record["FTR"],
      hthg: String.to_integer(record["HTHG"]),
      htag: String.to_integer(record["HTAG"]),
      htr: record["HTR"]
    ]
  end

  @doc """
  Converts a string of the format dd/mm/yy into a Date struct.
  """
  def to_date(string) do
    [day, month, year] = String.split(string, "/")

    {:ok, date} =
      Date.new(
        String.to_integer(year),
        String.to_integer(month),
        String.to_integer(day)
      )

    date
  end
end
