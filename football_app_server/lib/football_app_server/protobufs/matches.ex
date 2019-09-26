defmodule Protobufs.MatchesProtobuf do
  @moduledoc """
  The Matches Protobuf module.
  """

  use Protobuf, from: Path.expand("../../../proto/matches.proto", __DIR__)

  @doc """
  Creates a Matches struct.

  ## Examples

      iex> Protobufs.MatchesProtobuf.Matches.new([])
      %Protobufs.MatchesProtobuf.Matches{matches: []}

  """
  def new(list) do
    Enum.reduce(list, Protobufs.MatchesProtobuf.Matches.new(), fn elem, map ->
      append(map, elem)
    end)
  end

  @doc """
  Appends a league to the given Matches struct.

  ## Examples

      iex> Protobufs.MatchesProtobuf.Matches.new([]) |> Protobufs.MatchesProtobuf.append(["19/08/2016", "La Coruna", "Eibar", "2", "1", "H", "0", "0", "D"])
      %Protobufs.MatchesProtobuf.Matches{
        matches: [
          %Protobufs.MatchesProtobuf.Matches.Match{
            away_team: "Eibar",
            date: "19/08/2016",
            ftag: "1",
            fthg: "2",
            ftr: "H",
            home_team: "La Coruna",
            htag: "0",
            hthg: "0",
            htr: "D"
          }
        ]
      }

  """
  def append(map, [date, home_team, away_team, fthg, ftag, ftr, hthg, htag, htr]) do
    match =
      Protobufs.MatchesProtobuf.Matches.Match.new(
        date: date,
        home_team: home_team,
        away_team: away_team,
        fthg: fthg,
        ftag: ftag,
        ftr: ftr,
        hthg: hthg,
        htag: htag,
        htr: htr
      )

    %{map | matches: map.matches ++ [match]}
  end

  def to_protobuf(map) do
    Protobufs.MatchesProtobuf.Matches.encode(map)
  end
end
